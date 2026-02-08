#lang racket

(require racket/set)
(require racket/vector)

(define (k-divisible-elements-subarrays nums k p)
  (let* ([n (length nums)]
         [nums-vec (list->vector nums)]
         [distinct-subarrays (make-set equal?)])

    (for ([i (in-range n)])
      (let ([current-divisible-count 0]
            [current-subarray-elements '()]) ; Builds the subarray elements in reverse order

        (for ([j (in-range i n)])
          (let ([val (vector-ref nums-vec j)])
            (when (= (modulo val p) 0)
              (set! current-divisible-count (+ current-divisible-count 1)))

            (set! current-subarray-elements (cons val current-subarray-elements))

            (when (<= current-divisible-count k)
              (set-add! distinct-subarrays (reverse current-subarray-elements)))))))

    (set-count distinct-subarrays)))