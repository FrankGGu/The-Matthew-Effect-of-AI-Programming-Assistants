(define (largestValues root)
  (define (helper node level result)
    (if (null? node)
        result
        (let* ((new-result (if (< level (length result))
                               result
                               (append result (list (car (node-value node))))))
               (current-max (if (< level (length result))
                                (max (car (last new-result)) (car (node-value node)))
                                (car (node-value node)))))
          (begin
            (set! result (append (butlast new-result) (list current-max)))
            (helper (left node) (+ level 1) result)
            (helper (right node) (+ level 1) result)))))
  (helper root 0 '()))