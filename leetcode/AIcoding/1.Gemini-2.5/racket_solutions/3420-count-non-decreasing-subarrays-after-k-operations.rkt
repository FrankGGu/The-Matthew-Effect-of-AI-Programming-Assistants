#lang racket

(define (solve nums k)
  (define n (vector-length nums))

  ;; Prefix sums for efficient calculation of sum_nums
  (define prefix-sums (make-vector (+ n 1) 0))
  (for ([i (in-range n)])
    (vector-set! prefix-sums (+ i 1) (+ (vector-ref prefix-sums i) (vector-ref nums i))))

  ;; Segment tree structure:
  ;; Each node stores a list: (sum-val max-val)
  ;; sum-val: sum of elements in the range represented by the node
  ;; max-val: maximum element in the range represented by the node
  (define tree (make-vector (* 4 n) (list 0 0)))

  ;; Builds the segment tree
  ;; node: current node index in the tree array
  ;; L, R: start and end indices of the current segment in nums
  (define (build node L R)
    (if (= L R)
        ;; Leaf node: store the value and max of the single element
        (vector-set! tree node (list (vector-ref nums L) (vector-ref nums L)))
        (let* ([M (quotient (+ L R) 2)])
          ;; Recursively build left and right children
          (build (* 2 node) L M)
          (build (+ (* 2 node) 1) (+ M 1) R)
          ;; Combine results from children
          (let* ([left-node-data (vector-ref tree (* 2 node))]
                 [right-node-data (vector-ref tree (+ (* 2 node) 1))]
                 [sum-val (+ (car left-node-data) (car right-node-data))]
                 [max-val (max (cadr left-node-data) (cadr right-node-data))])
            (vector-set! tree node (list sum-val max-val))))))

  ;; Query function to calculate sum of prefix maximums for a range [query-L, query-R]
  ;; This function returns a list: (sum-of-max-prefixes, max-val-encountered-up-to-query-R)
  ;; node: current node index in the tree array
  ;; L, R: start and end indices of the current segment in nums (covered by 'node')
  ;; query-L, query-R: start and end indices of the query range
  ;; current-max-from-left: the maximum value encountered so far from the left of the query range
  (define (query-sum-max-prefix node L R query-L query-R current-max-from-left)
    ;; If current segment is completely outside the query range
    (if (or (> L query-R) (< R query-L))
        (list 0 current-max-from-left) ; Return 0 sum and propagate current-max-from-left
        ;; If current segment is completely within the query range
        (let ([node-data (vector-ref tree node)])
          ;; Optimization: if all elements in this segment are <= current-max-from-left,
          ;; then their modified values will all be current-max-from-left.
          (if (and (<= query-L L) (>= query-R R) (<= (cadr node-data) current-max-from-left))
              (list (* current-max-from-left (- R L -1)) current-max-from-left)
              ;; If it's a leaf node (single element)
              (if (= L R)
                  (let ([val (car node-data)])
                    (list (max current-max-from-left val) (max current-max-from-left val)))
                  ;; Recurse for internal node
                  (let* ([M (quotient (+ L R) 2)]
                         ;; Query left child
                         [left-res (query-sum-max-prefix (* 2 node) L M query-L query-R current-max-from-left)]
                         [left-sum (car left-res)]
                         [left-max-after (cadr left-res)] ; Max value after querying left child
                         ;; Query right child, using max value from left part as new base
                         [right-res (query-sum-max-prefix (+ (* 2 node) 1) (+ M 1) R query-L query-R left-max-after)]
                         [right-sum (car right-res)]
                         [right-max-after (cadr right-res)]) ; Max value after querying right child
                    (list (+ left-sum right-sum) right-max-after)))))))

  ;; Build the segment tree for the entire array
  (build 1 0 (- n 1))

  (define total-subarrays 0)

  ;; Iterate through all possible starting points 'i'
  (for ([i (in-range n)])
    (define low i)
    (define high (- n 1))
    (define best-j (- i 1)) ; Stores the largest 'j' such that cost(i, j) <= k

    ;; Binary search for the largest 'j' for the current 'i'
    (let loop ([l low] [h high] [bj best-j])
      (if (> l h)
          (set! best-j bj) ; Binary search finished, update best-j
          (let* ([mid (quotient (+ l h) 2)]
                 ;; Calculate sum of modified elements (sum_max_prefixes) for [i, mid]
                 ;; The base value for the first element nums[i] is nums[i] itself.
                 [sum-max-prefixes (car (query-sum-max-prefix 1 0 (- n 1) i mid (vector-ref nums i)))]
                 ;; Calculate sum of original elements (sum_nums) for [i, mid] using prefix sums
                 [sum-nums (- (vector-ref prefix-sums (+ mid 1)) (vector-ref prefix-sums i))]
                 ;; Calculate the cost
                 [cost (- sum-max-prefixes sum-nums)])
            (if (<= cost k)
                (loop (+ mid 1) h mid) ; Cost is within budget, try for a larger 'j'
                (loop l (- mid 1) bj)))))) ; Cost is too high, try for a smaller 'j'

    ;; Add the number of valid subarrays starting at 'i'
    ;; If best-j is i-1, no valid subarray, so (i-1 - i + 1) = 0
    (set! total-subarrays (+ total-subarrays (- best-j i -1))))

  total-subarrays)