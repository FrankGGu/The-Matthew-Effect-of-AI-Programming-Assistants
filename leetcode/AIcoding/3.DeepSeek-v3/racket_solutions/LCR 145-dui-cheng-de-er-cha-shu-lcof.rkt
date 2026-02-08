(define (is-symmetric root)
  (define (mirror? left right)
    (cond [(and (null? left) (null? right)) #t]
          [(or (null? left) (null? right)) #f]
          [(not (= (car left) (car right))) #f]
          [else (and (mirror? (cadr left) (caddr right))
                     (mirror? (caddr left) (cadr right)))]))
  (if (null? root)
      #t
      (mirror? (cadr root) (caddr root))))