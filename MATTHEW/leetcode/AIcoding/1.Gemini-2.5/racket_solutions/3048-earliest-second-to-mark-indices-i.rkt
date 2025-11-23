#lang racket

(require data/heap)

(define (earliest-second-to-mark-indices-i nums changeIndices)
  (define n (vector-length nums))
  (define m (vector-length changeIndices))

  (define (check t pure-return)
    ;; If t is less than n, it's impossible to mark n indices.
    ;; This condition is covered by the binary search range (left starts at n),
    ;; so `t` will always be >= `n`.

    (define last-occurrence (make-vector n -1))
    (for ([k (in-range t)]) ; seconds 0 to t-1 (representing 1 to t)
      (define idx (- (vector-ref changeIndices k) 1))
      (when (and (>= idx 0) (< idx n))
        (vector-set! last-occurrence idx k))) ; Store 0-indexed second

    ;; Check if all indices can be marked at least once by time t
    (for ([i (in-range n)])
      (when (= (vector-ref last-occurrence i) -1)
        (pure-return #f))) ; Exit early if an index cannot be marked

    (define pq (make-heap >)) ; Max-heap for nums[i] values
    (define current-required-decrements (apply + (vector->list nums)))
    (define marked-indices-count 0)
    (define seconds-spent-on-decrements 0)

    (for ([k (in-range t)]) ; seconds 0 to t-1
      (define idx-at-k (- (vector-ref changeIndices k) 1))
      (when (and (>= idx-at-k 0) (< idx-at-k n) (= (vector-ref last-occurrence idx-at-k) k))
        ; This is the last chance to mark idx-at-k
        (heap-add! pq (vector-ref nums idx-at-k)))

      (if (heap-empty? pq)
          ; No critical index to mark at this second. Use it for a generic decrement.
          (set! seconds-spent-on-decrements (+ seconds-spent-on-decrements 1))
          ; We have critical indices. We must mark one.
          ; To maximize the chance of marking all, pick the one that costs the most decrements.
          (begin
            (define val (heap-extract-max! pq))
            (set! seconds-spent-on-decrements (+ seconds-spent-on-decrements 1)) ; 1 second for the mark operation.
            (set! current-required-decrements (- current-required-decrements val)) ; val decrements are now covered.
            (set! marked-indices-count (+ marked-indices-count 1)))))

    (and (= marked-indices-count n)
         (>= seconds-spent-on-decrements current-required-decrements)))

  ;; Binary search for the earliest 't'
  (define ans -1)
  (define left n)
  (define right m) ; Max possible second is m

  ;; If m < n, it's impossible. The binary search will correctly return -1
  ;; because 'left' will eventually exceed 'right' (e.g., if 'n' is 5 and 'm' is 3,
  ;; 'left' starts at 5, 'right' at 3, loop doesn't run, 'ans' is -1).

  (call/ec
   (lambda (pure-return)
     (while (<= left right)
       (define mid (+ left (quotient (- right left) 2)))
       (if (check mid pure-return)
           (begin
             (set! ans mid)
             (set! right (- mid 1)))
           (set! left (+ mid 1))))
     ans)))