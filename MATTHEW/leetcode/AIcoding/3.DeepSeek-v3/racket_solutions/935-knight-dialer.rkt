#lang racket

(define (knight-dialer n)
  (define mod 1000000007)
  (define moves '((4 6) (6 8) (7 9) (4 8) (0 3 9) () (0 1 7) (2 6) (1 3) (2 4)))
  (define dp (make-vector 10 1))
  (define new-dp (make-vector 10 0))

  (for ([i (in-range 1 n)])
    (for ([j (in-range 10)])
      (vector-set! new-dp j 0)
      (for ([next (in-list (list-ref moves j))])
        (vector-set! new-dp j (modulo (+ (vector-ref new-dp j) (vector-ref dp next)) mod))))
    (set! dp (vector-copy new-dp)))

  (if (= n 1)
      10
      (modulo (apply + (vector->list dp)) mod)))