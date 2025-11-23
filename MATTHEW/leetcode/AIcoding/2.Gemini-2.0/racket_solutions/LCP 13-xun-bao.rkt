(define (minimal-steps grid)
  (define m (vector-length grid))
  (define n (vector-length (vector-ref grid 0)))

  (define (find-start)
    (for*/first ([i (in-range m)]
                 [j (in-range n)]
                 [(= (vector-ref (vector-ref grid i) j) 'S')])
      (cons i j)))

  (define (find-obstacles)
    (for*/list ([i (in-range m)]
                 [j (in-range n)]
                 [(= (vector-ref (vector-ref grid i) j) 'O')])
      (cons i j)))

  (define (find-treasures)
    (for*/list ([i (in-range m)]
                 [j (in-range n)]
                 [(= (vector-ref (vector-ref grid i) j) 'T')])
      (cons i j)))

  (define (find-locks)
    (for*/list ([i (in-range m)]
                 [j (in-range n)]
                 [(= (vector-ref (vector-ref grid i) j) 'X')])
      (cons i j)))

  (define start (find-start))
  (define treasures (find-treasures))
  (define obstacles (find-obstacles))
  (define locks (find-locks))

  (define (bfs start target)
    (define visited (make-hash))
    (define queue (list (cons start 0)))
    (hash-set! visited start #t)

    (define (valid? pos)
      (and (>= (car pos) 0) (< (car pos) m)
           (>= (cdr pos) 0) (< (cdr pos) n)
           (not (hash-has-key? visited pos))
           (not (member pos obstacles))
           (not (equal? (vector-ref (vector-ref grid (car pos)) (cdr pos)) 'D'))))

    (let loop ()
      (if (null? queue)
          #f
          (let ([curr (car queue)]
                [dist (cdr (car queue))])
            (cond
              [(equal? (car curr) target) dist]
              [else
               (let ([neighbors (list (cons (- (car curr) 1) (cdr curr))
                                       (cons (+ (car curr) 1) (cdr curr))
                                       (cons (car curr) (- (cdr curr) 1))
                                       (cons (car curr) (+ (cdr curr) 1)))])
                 (for-each (lambda (neighbor)
                             (if (valid? neighbor)
                                 (begin
                                   (hash-set! visited neighbor #t)
                                   (set! queue (append queue (list (cons neighbor (+ dist 1)))))))) neighbors))
               (set! queue (cdr queue))
               (loop)])))))

  (define (solve)
    (define (calculate-total-distance perm)
      (let loop ([curr start]
                 [remaining perm]
                 [total-distance 0])
        (cond
          [(null? remaining) total-distance]
          [else
           (let ([next (car remaining)]
                 [distance (bfs curr next)])
             (if (not distance)
                 #f
                 (loop next (cdr remaining) (+ total-distance distance))))]))

    (let ([perms (permutations treasures)])
      (foldr (lambda (perm acc)
                 (let ([distance (calculate-total-distance perm)])
                   (cond
                     [(not distance) acc]
                     [(not acc) distance]
                     [else (min distance acc)])))
             #f perms)))

  (let ([result (solve)])
    (if result result -1)))