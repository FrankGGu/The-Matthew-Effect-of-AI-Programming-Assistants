(define (grid-teleportation-traversal grid teleporters)
  (let* ([m (length grid)]
         [n (length (first grid))]
         [visited (make-vector m (make-vector n #f))]
         [q (list (list 0 0 0))] ; (row, col, steps)
         [result '()])
    (vector-set! (vector-ref visited 0) 0 #t)
    (letrec ([bfs (lambda (q)
                      (if (empty? q)
                          result
                          (let* ([curr (first q)]
                                 [row (first curr)]
                                 [col (second curr)]
                                 [steps (third curr)])
                            (cond
                              [(and (= row (- m 1)) (= col (- n 1)))
                               (bfs (append (rest q) (list steps)))]
                              [else
                               (let ([next-moves (list
                                                   (list (+ row 1) col)
                                                   (list (- row 1) col)
                                                   (list row (+ col 1))
                                                   (list row (- col 1)))])
                                 (letrec ([process-moves (lambda (moves)
                                                             (cond
                                                               [(empty? moves) #f]
                                                               [else
                                                                (let* ([next-row (first (first moves))]
                                                                       [next-col (second (first moves))])
                                                                  (cond
                                                                    [(and (>= next-row 0) (< next-row m) (>= next-col 0) (< next-col n) (not (vector-ref (vector-ref visited next-row) next-col)))
                                                                     (begin
                                                                       (vector-set! (vector-ref visited next-row) next-col #t)
                                                                       (bfs (append (rest q) (list (list next-row next-col (+ steps 1))))))
                                                                     #t]
                                                                    [else
                                                                     (process-moves (rest moves))]))]))])
                                   (let ([teleport-move (findf (lambda (teleporter)
                                                                 (and (= (first teleporter) row) (= (second teleporter) col)))
                                                               teleporters)])
                                     (if teleport-move
                                         (let* ([next-row (third teleport-move)]
                                                [next-col (fourth teleport-move)])
                                           (if (and (>= next-row 0) (< next-row m) (>= next-col 0) (< next-col n) (not (vector-ref (vector-ref visited next-row) next-col)))
                                               (begin
                                                 (vector-set! (vector-ref visited next-row) next-col #t)
                                                 (bfs (append (rest q) (list (list next-row next-col (+ steps 1)))))
                                                 #t)
                                               (process-moves next-moves)))
                                         (process-moves next-moves))))))]))))])
      (bfs q))))