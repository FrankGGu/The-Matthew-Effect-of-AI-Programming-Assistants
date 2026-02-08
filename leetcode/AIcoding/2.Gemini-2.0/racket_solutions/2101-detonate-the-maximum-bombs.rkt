(define (maximum-detonation bombs)
  (define n (length bombs))
  (define adj-list (make-vector n '()))
  (for/list ([i (in-range n)])
    (for/list ([j (in-range n)])
      (when (and (!= i j) (in-range? i j bombs))
        (vector-set! adj-list i (cons j (vector-ref adj-list i))))))

  (define (in-range? i j bombs)
    (let ([xi (list-ref (list-ref bombs i) 0)]
          [yi (list-ref (list-ref bombs i) 1)]
          [ri (list-ref (list-ref bombs i) 2)]
          [xj (list-ref (list-ref bombs j) 0)]
          [yj (list-ref (list-ref bombs j) 1)])
      (<= (expt (- xi xj) 2) (* (expt ri 2) (- 1 (expt (/ (- xi xj) ri) 2))))
      (<= (+ (expt (- xi xj) 2) (expt (- yi yj) 2)) (expt ri 2))))

  (define (bfs start)
    (define visited (make-vector n #f))
    (define q (list start))
    (vector-set! visited start #t)
    (define count 1)

    (let loop ([q q])
      (if (empty? q)
          count
          (let ([curr (car q)])
            (let ([neighbors (vector-ref adj-list curr)])
              (for-each (lambda (neighbor)
                           (when (not (vector-ref visited neighbor))
                             (vector-set! visited neighbor #t)
                             (set! count (+ count 1))
                             (set! q (append q (list neighbor)))))
                        neighbors))
            (loop (cdr q))))))

  (let loop ([i 0] [max-bombs 0])
    (if (= i n)
        max-bombs
        (let ([detonated-count (bfs i)])
          (loop (+ i 1) (max max-bombs detonated-count))))))