#lang racket

(define (count-stepping-numbers low high)
  (define (stepping? n)
    (let loop ([prev (remainder n 10)] [n (quotient n 10)])
      (if (zero? n)
          #t
          (let ([curr (remainder n 10)])
            (and (= 1 (abs (- curr prev)))
                 (loop curr (quotient n 10)))))))

  (define count 0)
  (for ([i (in-range low (add1 high))])
    (when (stepping? i)
      (set! count (add1 count))))
  count)