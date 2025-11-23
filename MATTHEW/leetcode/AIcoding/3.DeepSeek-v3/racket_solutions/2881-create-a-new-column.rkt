(define (create-a-new-column df)
  (define new-df (hash-copy df))
  (hash-set! new-df 'bonus (map (lambda (x) (* x 2)) (hash-ref df 'salary)))
  new-df)