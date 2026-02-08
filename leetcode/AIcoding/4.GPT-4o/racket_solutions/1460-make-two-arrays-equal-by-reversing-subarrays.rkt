(define (canBeEqual target arr)
  (define (count-elements lst)
    (foldl (lambda (x acc) (hash-update! acc x add1 0)) (make-hash) lst))
  (equal? (count-elements target) (count-elements arr)))

(define (main)
  (let ([target (vector->list (vector-ref (vector-ref (read) 0) 0))] 
        [arr (vector->list (vector-ref (vector-ref (read) 1) 0))])
    (display (canBeEqual target arr))))

(main)