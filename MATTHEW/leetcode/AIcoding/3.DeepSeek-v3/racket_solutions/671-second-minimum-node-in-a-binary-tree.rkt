(define (find-second-minimum-value root)
  (define (collect-values node vals)
    (if (null? node)
        vals
        (collect-values (left node) (cons (val node) (collect-values (right node) vals)))))
  (let* ((vals (collect-values root '()))
         (unique-vals (sort (remove-duplicates vals) <)))
    (if (< (length unique-vals) 2)
        -1
        (second unique-vals))))