(define (btree-game-winning-move root n x)
  (define (count-nodes node)
    (if (null? node)
        0
        (+ 1 (count-nodes (car node)) (count-nodes (cdr node)))))

  (define (find-x root)
    (cond
      [(null? root) null]
      [(= (car root) x) root]
      [else (or (find-x (car root)) (find-x (cdr root)))]))

  (let* ([x-node (find-x root)]
         [left-count (count-nodes (car x-node))]
         [right-count (count-nodes (cdr x-node))]
         [parent-count (- n 1 left-count right-count)])
    (or (> parent-count (+ left-count right-count 1))
        (> left-count (+ parent-count right-count 1))
        (> right-count (+ parent-count left-count 1)))))