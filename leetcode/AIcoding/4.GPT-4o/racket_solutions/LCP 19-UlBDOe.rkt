(define (collect-the-leaves leaves)
  (define leaf-count (length leaves))
  (define (helper index path)
    (if (>= index leaf-count)
        path
        (let ((current (list-ref leaves index)))
          (if (or (equal? current 'red) (equal? current 'yellow))
              (helper (+ index 1) (cons current path))
              (helper (+ index 1) path)))))
  (reverse (helper 0 '())))

(collect-the-leaves '(red yellow green red))