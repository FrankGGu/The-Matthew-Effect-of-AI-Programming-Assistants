(define (oranges-rotting grid)
  (define rows (length grid))
  (define cols (length (car grid)))
  (define queue (make-queue))
  (define fresh-count 0)

  (for*/fold ([r 0] [i 0]) ([row grid] [row-idx (in-range rows)])
    (for*/fold ([c 0] [j 0]) ([cell row] [col-idx (in-range cols)])
      (cond
        [(equal? cell 2) (enqueue! queue (list row-idx col-idx))]
        [(equal? cell 1) (set! r (+ r 1))])
      (values r (+ j 1)))
    (values c (+ i 1)))

  (set! fresh-count r)
  (define minutes 0)

  (define (bfs)
    (cond
      [(queue-empty? queue) #t]
      [else
       (let ([size (queue-size queue)])
         (for ([i (in-range size)])
           (let* ([curr (dequeue! queue)]
                  [row (car curr)]
                  [col (cadr curr)]
                  [neighbors (list (list (- row 1) col)
                                    (list (+ row 1) col)
                                    (list row (- col 1))
                                    (list row (+ col 1)))]
                  )
             (for ([neighbor neighbors])
               (let ([nr (car neighbor)]
                     [nc (cadr neighbor)])
                 (cond
                   [(and (>= nr 0) (< nr rows) (>= nc 0) (< nc cols) (equal? (list-ref (list-ref grid nr) nc) 1))
                    (set! fresh-count (- fresh-count 1))
                    (set! (list-ref (list-ref grid nr) nc) 2)
                    (enqueue! queue (list nr nc))])))))
         (set! minutes (+ minutes 1))
         (bfs)]))

  (bfs)

  (if (equal? fresh-count 0)
      (if (zero? minutes)
          0
          (- minutes 1))
      -1))