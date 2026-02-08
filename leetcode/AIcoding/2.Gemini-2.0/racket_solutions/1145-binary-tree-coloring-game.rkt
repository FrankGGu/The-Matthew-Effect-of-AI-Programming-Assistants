(define (btreeGame root n x)
  (define (count-nodes node)
    (if (null? node)
        0
        (+ 1 (count-nodes (car node)) (count-nodes (cadr node)))))

  (define (find-x root x)
    (cond
      [(null? root) null]
      [(= (car root) x) root]
      [else (or (find-x (car root) x) (find-x (cadr root) x))]))

  (let* ([x-node (find-x root x)]
         [left-count (count-nodes (car x-node))]
         [right-count (count-nodes (cadr x-node))]
         [parent-count (- n 1 left-count right-count)])
    (or (> left-count (/ n 2)) (> right-count (/ n 2)) (> parent-count (/ n 2)))))