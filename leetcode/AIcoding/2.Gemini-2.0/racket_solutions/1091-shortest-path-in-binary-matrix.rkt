(define (shortest-path-binary-matrix grid)
  (define n (vector-length grid))
  (define (valid? r c)
    (and (>= r 0) (< r n) (>= c 0) (< c n) (= (vector-ref (vector-ref grid r) c) 0)))

  (define (bfs)
    (define q (queue))
    (enqueue! q (cons 0 0))
    (vector-set! (vector-ref grid 0) 0 1)
    (define directions '((-1 -1) (-1 0) (-1 1) (0 -1) (0 1) (1 -1) (1 0) (1 1)))

    (let loop ()
      (if (queue-empty? q)
          -1
          (let* ((curr (dequeue! q))
                 (r (car curr))
                 (c (cdr curr))
                 (dist (vector-ref (vector-ref grid r) c)))
            (if (and (= r (- n 1)) (= c (- n 1)))
                dist
                (begin
                  (for-each
                   (lambda (dir)
                     (let* ((new-r (+ r (car dir)))
                            (new-c (+ c (cdr dir))))
                       (if (valid? new-r new-c)
                           (begin
                             (vector-set! (vector-ref grid new-r) new-c (+ dist 1))
                             (enqueue! q (cons new-r new-c))))))
                   directions)
                  (loop)))))))

  (if (and (= (vector-ref (vector-ref grid 0) 0) 0) (= (vector-ref (vector-ref grid (- (vector-length grid) 1)) (- (vector-length grid) 1)) 0))
      (bfs)
      -1))