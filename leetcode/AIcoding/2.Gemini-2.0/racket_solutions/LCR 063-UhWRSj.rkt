(define (replaceWords dictionary sentence)
  (define dict-set (set dictionary))
  (define (find-shortest-prefix word)
    (for/first ([i (in-range 1 (add1 (string-length word)))])
      (let ([prefix (substring word 0 i)])
        (if (set-member? dict-set prefix)
            prefix
            #f))))
  (string-join (map (lambda (word) (or (find-shortest-prefix word) word)) (string-split sentence)) " "))