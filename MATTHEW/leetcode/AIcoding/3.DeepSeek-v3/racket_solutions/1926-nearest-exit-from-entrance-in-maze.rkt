#lang racket

(define (nearest-exit maze entrance)
  (let* ([rows (length maze)]
         [cols (if (zero? rows) 0 (string-length (car maze)))]
         [dirs '((0 1) (1 0) (0 -1) (-1 0))]
         [queue (mutable-set)]
         [visited (mutable-set)])
    (set-add! queue (list (car entrance) (cadr entrance) 0))
    (set-add! visited (list (car entrance) (cadr entrance)))
    (let loop ()
      (if (zero? (set-count queue))
          -1
          (let* ([current (set-first queue)]
                 [row (car current)]
                 [col (cadr current)]
                 [steps (caddr current)])
            (set-remove! queue current)
            (if (or (zero? row) (= row (sub1 rows)) (zero? col) (= col (sub1 cols)))
                (if (and (not (equal? (list row col) entrance)) (equal? (string-ref (list-ref maze row) col) #\.))
                    steps
                    (begin
                      (for ([dir dirs])
                        (let* ([new-row (+ row (car dir))]
                               [new-col (+ col (cadr dir))])
                          (when (and (>= new-row 0) (< new-row rows) (>= new-col 0) (< new-col cols)
                            (when (and (equal? (string-ref (list-ref maze new-row) new-col) #\.)
                                       (not (set-member? visited (list new-row new-col))))
                              (set-add! queue (list new-row new-col (add1 steps)))
                              (set-add! visited (list new-row new-col))))))
                      (loop)))
                (begin
                  (for ([dir dirs])
                    (let* ([new-row (+ row (car dir))]
                           [new-col (+ col (cadr dir))])
                      (when (and (>= new-row 0) (< new-row rows) (>= new-col 0) (< new-col cols)
                        (when (and (equal? (string-ref (list-ref maze new-row) new-col) #\.)
                               (not (set-member? visited (list new-row new-col))))
                          (set-add! queue (list new-row new-col (add1 steps)))
                          (set-add! visited (list new-row new-col)))))
                  (loop)))))))