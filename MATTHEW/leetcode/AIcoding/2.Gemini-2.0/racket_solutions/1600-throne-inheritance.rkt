(define throne-inheritance%
  (class object%
    (init-field king-name
                birth-death-record
                children)
    (define/public (constructor king-name)
      (set! king-name king-name)
      (set! birth-death-record (make-hash))
      (set! children (make-hash))
      (hash-set! birth-death-record king-name #f)
      (hash-set! children king-name '()))
    (define/public (birth parent-name child-name)
      (hash-set! birth-death-record child-name #f)
      (hash-set! children parent-name (append (hash-ref children parent-name) (list child-name))))
    (define/public (death name)
      (hash-set! birth-death-record name #t))
    (define/public (get-inheritance-order)
      (define (dfs name)
        (cond
          [(and (hash-has-key? birth-death-record name) (not (hash-ref birth-death-record name))) (list name)]
          [else '()])
        (append (dfs name) (apply append (map dfs (hash-ref children name)))))

      (dfs king-name))
    ))

(provide throne-inheritance%)