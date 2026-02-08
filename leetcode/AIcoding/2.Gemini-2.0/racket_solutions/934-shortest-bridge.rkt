(define (shortest-bridge grid)
  (define n (vector-length grid))
  (define visited (make-vector n (lambda (_) (make-vector n #f))))
  (define island1 '())

  (define (is-valid? r c)
    (and (>= r 0) (< r n) (>= c 0) (< c n)))

  (define (dfs r c)
    (when (and (is-valid? r c) (not (vector-ref (vector-ref visited r) c)) (= (vector-ref (vector-ref grid r) c) 1))
      (vector-set! (vector-ref visited r) c #t)
      (set! island1 (cons (cons r c) island1))
      (dfs (+ r 1) c)
      (dfs (- r 1) c)
      (dfs r (+ c 1))
      (dfs r (- c 1))))

  (define (find-island)
    (for ([r (in-range n)] [c (in-range n)])
      (when (= (vector-ref (vector-ref grid r) c) 1)
        (dfs r c)
        (stop))))

  (find-island)

  (define queue island1)
  (define level 0)

  (define (bfs)
    (let loop ()
      (cond
        [(null? queue) #f]
        [else
         (let* ([qlen (length queue)])
           (for ([i (in-range qlen)])
             (let* ([curr (car queue)]
                    [r (car curr)]
                    [c (cdr curr)])
               (set! queue (cdr queue))
               (define neighbors
                 (list (cons (+ r 1) c)
                       (cons (- r 1) c)
                       (cons r (+ c 1))
                       (cons r (- c 1))))
               (for ([neighbor (in-list neighbors)])
                 (let ([nr (car neighbor)]
                       [nc (cdr neighbor)])
                   (when (is-valid? nr nc)
                     (cond
                       [(= (vector-ref (vector-ref grid nr) nc) 1)
                        (return #t)]
                       [(and (not (vector-ref (vector-ref visited nr) nc))
                             (= (vector-ref (vector-ref grid nr) nc) 0))
                        (vector-set! (vector-ref visited nr) nc #t)
                        (set! queue (cons (cons nr nc) queue))])))))))
           (set! level (+ level 1))
           (loop)])))

  (bfs)
  level)