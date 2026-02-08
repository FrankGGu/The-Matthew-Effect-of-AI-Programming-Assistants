(define (transport-gifts gifts k)
  (let ([n (length gifts)])
    (let loop ([l gifts]
               [res '()])
      (cond
        [(empty? l) (reverse res)]
        [(<= (car l) k) (loop (cdr l) (cons (car l) res))]
        [else (loop (cdr l) res)]))))