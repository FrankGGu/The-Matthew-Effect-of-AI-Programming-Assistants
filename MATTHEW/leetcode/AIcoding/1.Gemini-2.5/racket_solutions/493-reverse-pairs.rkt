#lang racket

(define (reverse-pairs nums)
  (define n (length nums))
  (if (zero? n)
      0
      (let ([vec (list->vector nums)])
        (define (merge-sort-and-count! arr low high)
          (if (>= low high)
              0
              (let* ([mid (+ low (quotient (- high low) 2))]
                     [left-count (merge-sort-and-count! arr low mid)]
                     [right-count (merge-sort-and-count! arr (+ mid 1) high)]
                     [cross-count (count-cross-pairs arr low mid high)])
                (merge! arr low mid high)
                (+ left-count right-count cross-count))))

        (define (count-cross-pairs arr low mid high)
          (let loop ([i low] [j (+ mid 1)] [count 0])
            (if (> i mid)
                count
                (let* ([val-i (vector-ref arr i)])
                  (let inner-loop ([k j])
                    (if (and (<= k high) (> val-i (* 2 (vector-ref arr k))))
                        (inner-loop (+ k 1))
                        (loop (+ i 1) k (+ count (- k (+ mid 1))))))))))

        (define (merge! arr low mid high)
          (define temp (make-vector (- high low -1)))
          (let loop ([i low] [j (+ mid 1)] [k 0])
            (cond
              [(and (<= i mid) (<= j high))
               (if (<= (vector-ref arr i) (vector-ref arr j))
                   (begin (vector-set! temp k (vector-ref arr i))
                          (loop (+ i 1) j (+ k 1)))
                   (begin (vector-set! temp k (vector-ref arr j))
                          (loop i (+ j 1) (+ k 1))))]
              [(<= i mid)
               (vector-set! temp k (vector-ref arr i))
               (loop (+ i 1) j (+ k 1))]
              [(<= j high)
               (vector-set! temp k (vector-ref arr j))
               (loop i (+ j 1) (+ k 1))]
              [else
               (void)]))
          (for ([idx (in-range 0 (vector-length temp))])
            (vector-set! arr (+ low idx) (vector-ref temp idx)))))

        (merge-sort-and-count! vec 0 (- n 1))))))