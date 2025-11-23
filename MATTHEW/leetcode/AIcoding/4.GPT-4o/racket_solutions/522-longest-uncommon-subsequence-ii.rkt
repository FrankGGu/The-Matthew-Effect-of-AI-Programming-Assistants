(define (findLUSlength strs)
  (define (is-subseq? a b)
    (define (helper a b)
      (cond
        [(null? a) #t]
        [(null? b) #f]
        [(equal? (car a) (car b)) (helper (cdr a) (cdr b))]
        [else (helper a (cdr b))]))
    (helper (string->list a) (string->list b)))

  (define (longest-uncommon)
    (for/fold ([max-len -1]) ([s strs])
      (if (not (any (lambda (x) (is-subseq? x s)) strs))
          (max max-len (string-length s))
          max-len)))

  (longest-uncommon))

(findLUSlength '("aaa","aaa","aa"))