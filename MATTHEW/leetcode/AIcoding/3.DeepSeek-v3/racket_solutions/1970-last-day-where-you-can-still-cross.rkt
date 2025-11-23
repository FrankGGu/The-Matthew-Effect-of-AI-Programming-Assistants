(define/contract (latest-day-to-cross row col cells)
  (-> exact-integer? exact-integer? (listof (listof exact-integer?)) exact-integer?)
  (define grid (make-vector row (make-vector col 0)))
  (define dirs '((0 1) (1 0) (0 -1) (-1 0)))

  (define (can-cross? day)
    (define visited (make-vector row (make-vector col #f)))
    (define q (make-queue))

    (for ([i (in-range row)])
      (vector-set! grid i (make-vector col 0)))

    (for ([cell (in-list (take cells day))])
      (define r (- (first cell) 1))
      (define c (- (second cell) 1))
      (vector-set! (vector-ref grid r) c 1))

    (for ([j (in-range col)])
      (when (zero? (vector-ref (vector-ref grid 0) j))
        (enqueue! q (cons 0 j))
        (vector-set! (vector-ref visited 0) j #t)))

    (let loop ()
      (if (queue-empty? q)
          #f
          (let ([curr (dequeue! q)])
            (define r (car curr))
            (define c (cdr curr))
            (if (= r (- row 1))
                #t
                (begin
                  (for ([dir (in-list dirs)])
                    (define nr (+ r (car dir)))
                    (define nc (+ c (cdr dir)))
                    (when (and (>= nr 0) (< nr row) (>= nc 0) (< nc col)
                              (zero? (vector-ref (vector-ref grid nr) nc))
                              (not (vector-ref (vector-ref visited nr) nc)))
                      (vector-set! (vector-ref visited nr) nc #t)
                      (enqueue! q (cons nr nc)))
                  (loop))))))

  (define (binary-search left right)
    (if (> left right)
        right
        (let ([mid (quotient (+ left right) 2)])
          (if (can-cross? mid)
              (binary-search (+ mid 1) right)
              (binary-search left (- mid 1))))))

  (binary-search 1 (length cells)))