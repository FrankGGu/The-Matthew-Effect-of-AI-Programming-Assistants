(define (min-push-box box start target obstacles)
  (define rows (vector-length box))
  (define cols (vector-length (vector-ref box 0)))

  (define (valid? row col)
    (and (>= row 0) (< row rows) (>= col 0) (< col cols)
         (not (equal? (vector-ref (vector-ref obstacles row) col) #t))))

  (define (bfs start-pos box-pos)
    (define visited (make-hash))
    (hash-set! visited (list start-pos box-pos) #t)
    (define q (list (list start-pos box-pos 0)))

    (define (neighbors pos)
      (define row (car pos))
      (define col (cadr pos))
      (list (list (- row 1) col) (list (+ row 1) col) (list row (- col 1)) (list row (+ col 1))))

    (let loop ((q q))
      (cond
        [(null? q) -1]
        [else
         (define current (car q))
         (define worker-pos (car current))
         (define box-pos (cadr current))
         (define moves (caddr current))

         (cond
           [(equal? box-pos target) moves]
           [else
            (for-each
             (lambda (next-worker-pos)
               (let* ((next-worker-row (car next-worker-pos))
                      (next-worker-col (cadr next-worker-pos))
                      (worker-row (car worker-pos))
                      (worker-col (cadr worker-pos))
                      (box-row (car box-pos))
                      (box-col (cadr box-pos)))
                 (cond
                   [(and (equal? next-worker-row box-row) (equal? next-worker-col box-col))
                    (define next-box-row (+ box-row (- box-row worker-row)))
                    (define next-box-col (+ box-col (- box-col worker-col)))
                    (cond
                      [(and (valid? next-box-row next-box-col) (valid? next-worker-row next-worker-col))
                       (define next-box-pos (list next-box-row next-box-col))
                       (define next-state (list next-worker-pos next-box-pos))
                       (cond
                         [(not (hash-has-key? visited next-state))
                          (hash-set! visited next-state #t)
                          (set! q (append q (list (list next-worker-pos next-box-pos (+ moves 1)))))]
                         [else #f])]
                      [else #f])]
                   [else
                    (cond
                      [(valid? next-worker-row next-worker-col)
                       (define next-state (list next-worker-pos box-pos))
                       (cond
                         [(not (hash-has-key? visited next-state))
                          (hash-set! visited next-state #t)
                          (set! q (append q (list (list next-worker-pos box-pos moves))))]
                         [else #f])]
                      [else #f])])])))
             (neighbors worker-pos))
            (loop (cdr q))])]))))

  (let* ((box-row (car box))
         (box-col (cadr box))
         (target-row (car target))
         (target-col (cadr target))
         (start-row (car start))
         (start-col (cadr start)))
    (bfs (list start-row start-col) (list box-row box-col))))