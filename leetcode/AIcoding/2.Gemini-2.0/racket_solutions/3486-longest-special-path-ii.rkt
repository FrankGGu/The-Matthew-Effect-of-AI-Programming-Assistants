(define (longest-special-path-ii n edges)
  (define graph (make-hash))
  (for-each (lambda (edge)
              (let ((u (car edge)) (v (cadr edge)) (w (caddr edge)))
                (hash-update! graph u (lambda (vs) (cons (list v w) vs)) '())))
            edges)

  (define (dfs u visited)
    (if (hash-has-key? graph u)
        (let ((neighbors (hash-ref graph u)))
          (foldl (lambda (neighbor max-len)
                   (let ((v (car neighbor)) (w (cadr neighbor)))
                     (if (not (member v visited))
                         (max max-len (+ w (dfs v (cons u visited))))
                         max-len)))
                 0
                 neighbors))
        0))

  (let loop ((u 1) (max-path 0))
    (if (> u n)
        max-path
        (let ((path-from-u (dfs u (list u))))
          (loop (+ u 1) (max max-path path-from-u))))))