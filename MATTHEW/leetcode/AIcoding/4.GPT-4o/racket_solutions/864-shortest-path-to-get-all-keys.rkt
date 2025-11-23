(define (shortest-path-all-keys grid)
  (define directions '((0 1) (0 -1) (1 0) (-1 0)))
  (define (valid? x y)
    (and (>= x 0) (< x (length grid))
         (>= y 0) (< y (length (vector-ref grid x)))))
  (define (bfs start)
    (define queue (list (cons start 0)))
    (define visited (make-hash))
    (hash-set! visited (list->vector start) #t)
    (define keys (for/fold ([acc 0]) ([row grid])
                    (for/fold ([acc2 acc]) ([cell row])
                      (if (char=? cell #\k) (+ acc2 1) acc2))))
    (let loop ([queue queue])
      (if (null? queue)
          -1
          (let* ([current (car queue)]
                 [pos (car current)]
                 [steps (cdr current)]
                 [x (car pos)]
                 [y (cadr pos)]
                 [next-keys (if (char=? (vector-ref (vector-ref grid x) y) #\@) 
                                0 
                                (if (char=? (vector-ref (vector-ref grid x) y) #\#) 
                                    0 
                                    (if (char=? (vector-ref (vector-ref grid x) y) #\k) 
                                        1 
                                        0)))])
                 [new-keys (+ next-keys (string->number (if (char=? (vector-ref (vector-ref grid x) y) #\k) "1" "0")))]))
            (for-each (lambda (direction)
                        (let* ([new-x (+ x (car direction))]
                               [new-y (+ y (cadr direction))]
                               [new-pos (list new-x new-y)])
                          (when (and (valid? new-x new-y)
                                     (not (hash-ref visited (list->vector new-pos) #f)))
                            (hash-set! visited (list->vector new-pos) #t)
                            (set! queue (append (cdr queue) (list (cons new-pos (+ steps 1))))))))
                    directions)
            (if (>= new-keys keys)
                steps
                (loop (cdr queue)))))))
  (define start (for/fold ([start '()] [found #f]) ([i (in-range (length grid))])
                  (for/fold ([start start] [found found]) ([j (in-range (length (vector-ref grid i)))])
                    (if (char=? (vector-ref (vector-ref grid i) j) #\@)
                        (list i j)
                        start)))
                  )
  (bfs start))