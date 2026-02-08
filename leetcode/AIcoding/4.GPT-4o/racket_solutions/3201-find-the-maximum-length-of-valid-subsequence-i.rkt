(define (max-length-valid-subseq nums)
  (define (is-valid subseq)
    (let loop ((s subseq) (prev #f))
      (cond
        [(null? s) #t]
        [(or (equal? prev #f) (not (= (car s) prev))) (loop (cdr s) (car s))]
        [else #f])))

  (define (helper nums current)
    (if (null? nums)
        (if (is-valid current) (length current) 0)
        (max (helper (cdr nums) current)
             (helper (cdr nums) (cons (car nums) current)))))

  (helper nums '()))

(max-length-valid-subseq '(1 2 3 1 2))