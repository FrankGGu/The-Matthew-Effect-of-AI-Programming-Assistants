(define/contract (closest-divisors num)
  (-> exact-integer? (listof exact-integer?))
  (define (find-divisors n)
    (let loop ([i (inexact->exact (floor (sqrt n)))])
      (cond
        [(<= i 0) (list 1 n)]
        [(= (remainder n i) 0) (list i (quotient n i))]
        [else (loop (sub1 i))])))
  (let ([d1 (find-divisors (add1 num))]
        [d2 (find-divisors (+ num 2))])
    (if (< (abs (- (car d1) (cadr d1))) (abs (- (car d2) (cadr d2))))
        d1
        d2)))