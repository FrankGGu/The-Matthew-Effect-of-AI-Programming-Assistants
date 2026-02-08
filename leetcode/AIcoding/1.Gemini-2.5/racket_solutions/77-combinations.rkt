(define/public (combine n k)
  (cond
    [(= k 0) '(())]
    [(< n k) '()]
    [else
     (let* ([combinations-with-n (map (lambda (c) (cons n c)) (combine (- n 1) (- k 1)))]
            [combinations-without-n (combine (- n 1) k)])
       (append combinations-with-n combinations-without-n))]))