(define (solve maze)
  (define rows (length maze))
  (define cols (length (car maze)))
  (define start-row (car (index-of-element maze 2)))
  (define start-col (cadr (index-of-element maze 2)))
  (define end-row (car (index-of-element maze 3)))
  (define end-col (cadr (index-of-element maze 3)))

  (define (index-of-element matrix element)
    (for*/list ([row (in-range (length matrix))]
                [col (in-range (length (car matrix)))]
                #:when (= (list-ref (list-ref matrix row) col) element))
      (list row col)))

  (define (valid-move? row col)
    (and (>= row 0) (< row rows) (>= col 0) (< col cols) (not (= (list-ref (list-ref maze row) col) 1))))

  (define (bfs)
    (define q (queue))
    (enqueue! q (list start-row start-col 0)) ; (row, col, distance)
    (define visited (make-hash))
    (hash-set! visited (list start-row start-col) #t)

    (define (explore)
      (if (queue-empty? q)
          -1
          (let* ([curr (dequeue! q)]
                 [row (car curr)]
                 [col (cadr curr)]
                 [dist (caddr curr)])
            (if (and (= row end-row) (= col end-col))
                dist
                (begin
                  (define neighbors (list (list (- row 1) col) (list (+ row 1) col) (list row (- col 1)) (list row (+ col 1))))
                  (for-each
                   (lambda (neighbor)
                     (let ([new-row (car neighbor)]
                           [new-col (cadr neighbor)])
                       (if (and (valid-move? new-row new-col) (not (hash-has-key? visited (list new-row new-col)))))
                           (begin
                             (enqueue! q (list new-row new-col (+ dist 1)))
                             (hash-set! visited (list new-row new-col) #t)))))
                   neighbors)
                  (explore))))))
    (explore))

  (bfs))