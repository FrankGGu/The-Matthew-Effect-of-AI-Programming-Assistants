(define (find-duplicate-subtrees root)
  (define ans '())
  (define seen (make-hash))
  (define dups (make-hash))

  (define (serialize node)
    (if (null? node)
        "#"
        (string-append
         (number->string (car node))
         ","
         (serialize (cadr node))
         ","
         (serialize (caddr node)))))

  (define (traverse node)
    (if (null? node)
        ""
        (let ([s (serialize node)])
          (cond
            [(hash-has-key? dups s) #f]
            [(hash-has-key? seen s)
             (hash-set! dups s #t)
             (set! ans (cons node ans))]
            [else (hash-set! seen s #t)])
          (traverse (cadr node))
          (traverse (caddr node))
          s)))

  (traverse root)
  ans)