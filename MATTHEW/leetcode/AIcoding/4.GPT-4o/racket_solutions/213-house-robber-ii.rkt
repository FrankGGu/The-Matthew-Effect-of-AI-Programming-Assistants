(define (rob nums)
  (define (rob-line houses)
    (define n (length houses))
    (cond
      [(= n 0) 0]
      [(= n 1) (car houses)]
      [else
       (define dp (make-vector n 0))
       (vector-set! dp 0 (car houses))
       (vector-set! dp 1 (max (car houses) (cadr houses)))
       (for ([i (in-range 2 n)])
         (vector-set! dp i (max (vector-ref dp (- i 1)) (+ (vector-ref dp (- i 2)) (list-ref houses i)))))
       (vector-ref dp (- n 1))]))

  (if (null? nums)
      0
      (max (rob-line (butlast nums)) (rob-line (cdr nums)))))

(define (butlast lst)
  (if (null? (cdr lst))
      '()
      (cons (car lst) (butlast (cdr lst)))))