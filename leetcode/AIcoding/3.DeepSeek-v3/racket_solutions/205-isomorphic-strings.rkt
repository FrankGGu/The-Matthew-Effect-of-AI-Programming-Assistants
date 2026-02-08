(define/contract (is-isomorphic s t)
  (-> string? string? boolean?)
  (let ([s->t (make-hash)]
        [t->s (make-hash)])
    (for ([sc (in-string s)]
          [tc (in-string t)])
      (cond
        [(and (hash-has-key? s->t sc) (not (equal? (hash-ref s->t sc) tc))) #f]
        [(and (hash-has-key? t->s tc) (not (equal? (hash-ref t->s tc) sc))) #f]
        [else (hash-set! s->t sc tc)
              (hash-set! t->s tc sc)]))
    #t))