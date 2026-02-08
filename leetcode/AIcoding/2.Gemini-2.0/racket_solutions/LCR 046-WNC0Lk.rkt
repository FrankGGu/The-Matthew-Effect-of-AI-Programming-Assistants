(define (right-side-view root)
  (define (helper node level result)
    (cond
      [(null? node) result]
      [else
       (if (= (length result) level)
           (helper (right-child node) (+ level 1) (append result (list (val node))))
           (helper (right-child node) (+ level 1) result))
       (helper (left-child node) (+ level 1) result)]))
  (if (null? root)
      '()
      (helper root 0 '())))