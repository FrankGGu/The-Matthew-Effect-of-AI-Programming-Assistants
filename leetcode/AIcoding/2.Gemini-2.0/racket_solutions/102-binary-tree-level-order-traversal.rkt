(define (levelOrder root)
  (if (null? root)
      '()
      (let loop ([queue (list root)] [result '()])
        (if (empty? queue)
            result
            (let* ([current-level (map (lambda (node) (car node)) queue)]
                   [next-queue (foldr append '() (map (lambda (node)
                                                        (let ([car-node (car node)])
                                                          (cond
                                                            [(and (not (null? (car-node 'left))) (not (null? (car-node 'right)))) (list (cons (car-node 'left) '()) (cons (car-node 'right) '()))]
                                                            [(not (null? (car-node 'left)))) (list (cons (car-node 'left) '()))]
                                                            [(not (null? (car-node 'right)))) (list (cons (car-node 'right) '()))]
                                                            [else '()]))) queue))])
              (loop next-queue (append result (list (map (lambda (node) (car node 'val)) current-level))))))))))