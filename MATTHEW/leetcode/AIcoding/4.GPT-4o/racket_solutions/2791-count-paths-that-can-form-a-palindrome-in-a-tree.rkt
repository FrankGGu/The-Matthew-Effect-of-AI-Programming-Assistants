(define (count-palindrome-paths root)
  (define (count-paths node path)
    (if (null? node)
        0
        (let* ((new-path (cons (tree-val node) path))
               (path-count (foldl (lambda (acc val)
                                     (if (even? (count (lambda (x) (equal? x val)) new-path))
                                         acc
                                         (+ acc 1)))
                                   0
                                   new-path)))
          (if (and (null? (left node)) (null? (right node)))
              (if (<= path-count 1) 1 0)
              (+ (count-paths (left node) new-path)
                 (count-paths (right node) new-path))))))

  (count-paths root '()))