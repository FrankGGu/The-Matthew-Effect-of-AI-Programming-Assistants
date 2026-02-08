#lang racket

(define (maximum-balanced-subsequence-sum nums)
  (define n (vector-length nums))

  ;; Step 1: Collect all diff_values = nums[i] - i
  (define diff-values (make-vector n))
  (for ([i (in-range n)])
    (vector-set! diff-values i (- (vector-ref nums i) i)))

  ;; Step 2: Create a sorted list of unique diff_values (coords)
  (define unique-diffs (sort (remove-duplicates (vector->list diff-values)) <))

  ;; Step 3: Create a map diff_to_idx
  (define diff-to-idx (make-hash))
  (for ([val unique-diffs] [idx (in-naturals)])
    (hash-set! diff-to-idx val idx))

  ;; Step 4: Initialize a segment tree
  (define tree-size (length unique-diffs))
  ;; Use a sufficiently small number for negative infinity.
  ;; Sums can be up to 10^5 * 10^9 = 10^14.
  ;; Smallest sum can be 10^5 * -10^9 = -10^14.
  (define neg-inf (- (expt 10 15))) 

  ;; Segment tree array. Size 2*tree-size.
  ;; Leaves are at indices [tree-size, 2*tree-size - 1].
  ;; Internal nodes are at [1, tree-size - 1]. Index 0 is unused.
  (define seg-tree (make-vector (* 2 tree-size) neg-inf))

  ;; Segment tree update function (point update, max value)
  (define (seg-tree-update idx val)
    (let ([leaf-idx (+ idx tree-size)])
      (vector-set! seg-tree leaf-idx (max (vector-ref seg-tree leaf-idx) val)) ; Update leaf
      (let loop ([i (quotient leaf-idx 2)]) ; Start from parent of the leaf
        (when (> i 0) ; While not root (index 0 is unused, root is 1)
          (vector-set! seg-tree i (max (vector-ref seg-tree (* 2 i)) (vector-ref seg-tree (+ (* 2 i) 1))))
          (loop (quotient i 2))))))

  ;; Segment tree query function (range max query)
  (define (seg-tree-query left right)
    (let loop ([l (+ left tree-size)]
               [r (+ right tree-size)]
               [res neg-inf])
      (cond
        [(> l r) res]
        [else
         (let ([current-res res])
           (when (odd? l) ; If left child is odd, it's a right child of its parent. Include it.
             (set! current-res (max current-res (vector-ref seg-tree l)))
             (set! l (+ l 1)))
           (when (even? r) ; If right child is even, it's a left child of its parent. Include it.
             (set! current-res (max current-res (vector-ref seg-tree r)))
             (set! r (- r 1)))
           (loop (quotient l 2) (quotient r 2) current-res))])))

  ;; Step 5: Initialize overall_max_sum
  ;; The maximum sum could be a single element. Since N >= 1, there's always at least one element.
  ;; Initialize with the smallest possible value.
  (define overall-max-sum neg-inf)

  ;; Step 6: Iterate through nums
  (for ([i (in-range n)])
    (define current-num (vector-ref nums i))
    (define current-diff (- current-num i))
    (define idx (hash-ref diff-to-idx current-diff))

    ;; Query the segment tree for the maximum sum in the range [0, idx]
    (define prev-max-subsequence-sum (seg-tree-query 0 idx))

    ;; Calculate current_subsequence_sum
    ;; If prev-max-subsequence-sum is neg-inf, it means no valid previous subsequence.
    ;; In this case, we start a new subsequence with current-num.
    (define current-subsequence-sum
      (+ current-num (if (= prev-max-subsequence-sum neg-inf)
                         0 ; Start a new subsequence
                         prev-max-subsequence-sum)))

    ;; Update the segment tree at index idx
    (seg-tree-update idx current-subsequence-sum)

    ;; Update overall_max_sum
    (set! overall-max-sum (max overall-max-sum current-subsequence-sum)))

  overall-max-sum)