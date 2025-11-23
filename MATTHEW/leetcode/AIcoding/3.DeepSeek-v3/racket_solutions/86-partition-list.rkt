(define/contract (partition head x)
  (-> (or/c list? null?) exact-integer? (or/c list? null?))
  (let ([before (make-parameter null)]
        [after (make-parameter null)])
    (let loop ([node head])
      (when (not (null? node))
        (if (< (car node) x)
            (begin
              (set! before (cons (car node) (before)))
              (loop (cdr node)))
            (begin
              (set! after (cons (car node) (after)))
              (loop (cdr node))))))
    (append (reverse (before)) (reverse (after)))))