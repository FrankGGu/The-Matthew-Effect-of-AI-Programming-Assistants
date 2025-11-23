(define (is-cousins root x y)
  (letrec (
           (bfs (lambda (node queue depth x-parent y-parent x-depth y-depth)
                  (cond
                    [(null? queue) (cond
                                      [(and (= x-depth y-depth) (not (equal? x-parent y-parent))) #t]
                                      [else #f])]
                    [else
                     (let* ([q (queue-peek queue)]
                            [new-queue (queue-remove! queue)]
                            [curr-node (car q)]
                            [curr-depth (cadr q)]
                            [parent-val (caddr q)])
                       (cond
                         [(not (null? curr-node))
                          (let ([left-child (car curr-node)]
                                [right-child (cadr curr-node)])
                            (when (and (not (null? left-child)) (= (car left-child) x))
                              (set! x-parent (car curr-node))
                              (set! x-depth (+ curr-depth 1)))
                            (when (and (not (null? left-child)) (= (car left-child) y))
                              (set! y-parent (car curr-node))
                              (set! y-depth (+ curr-depth 1)))
                            (when (and (not (null? right-child)) (= (car right-child) x))
                              (set! x-parent (car curr-node))
                              (set! x-depth (+ curr-depth 1)))
                            (when (and (not (null? right-child)) (= (car right-child) y))
                              (set! y-parent (car curr-node))
                              (set! y-depth (+ curr-depth 1)))

                            (let ([new-queue2
                                   (cond
                                     [(and (not (null? left-child)) (not (null? right-child)))
                                      (begin
                                        (queue-add! new-queue (cons left-child (cons (+ curr-depth 1) (cons (car curr-node) '()))))
                                        (queue-add! new-queue (cons right-child (cons (+ curr-depth 1) (cons (car curr-node) '()))))
                                        new-queue)]
                                     [(not (null? left-child))
                                      (begin
                                        (queue-add! new-queue (cons left-child (cons (+ curr-depth 1) (cons (car curr-node) '()))))
                                        new-queue)]
                                     [(not (null? right-child))
                                      (begin
                                        (queue-add! new-queue (cons right-child (cons (+ curr-depth 1) (cons (car curr-node) '()))))
                                        new-queue)]
                                     [else
                                      new-queue])])
                              (bfs curr-node new-queue2 depth x-parent y-parent x-depth y-depth))))
                         [else (bfs curr-node new-queue depth x-parent y-parent x-depth y-depth)]))]))))
    (bfs root (queue (cons root (cons 0 (cons #f '())))) 0 #f #f #f #f)))