(define (largestValues root)
  (define (bfs queue levels)
    (if (empty? queue)
        levels
        (let* ([level-size (length queue)]
               [level-values '()]
               [new-queue '()])
          (for ([i (in-range level-size)])
            (let* ([node (car queue)]
                   [queue (cdr queue)])
              (set! level-values (cons (car node) level-values))
              (when (cadr node)
                (set! new-queue (append new-queue (list (cons (car (cadr node)) (cdr (cadr node)))))))
              (when (caddr node)
                (set! new-queue (append new-queue (list (cons (car (caddr node)) (cdr (caddr node)))))))
              (set! queue queue)))
          (bfs new-queue (append levels (list (apply max level-values)))))))

  (if (null? root)
      '()
      (bfs (list (cons (car root) (cdr root))) '())))