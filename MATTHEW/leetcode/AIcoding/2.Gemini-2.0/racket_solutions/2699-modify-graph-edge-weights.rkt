(define (modified-graph-edges n edges source destination target)
  (define adj (make-vector (add1 n) '()))
  (define unknown-edges '())
  (for ([edge edges])
    (let ([u (car edge)]
          [v (cadr edge)]
          [w (caddr edge)])
      (vector-set! adj u (cons (list v w) (vector-ref adj u)))
      (vector-set! adj v (cons (list u w) (vector-ref adj v)))
      (when (= w -1)
        (set! unknown-edges (cons edge unknown-edges)))))

  (define (dijkstra adj start)
    (define dist (make-vector (add1 n) +inf.0))
    (vector-set! dist start 0.0)
    (define pq (mutable-priority-queue <))
    (mutable-priority-queue-add! pq (list 0.0 start))
    (while (not (mutable-priority-queue-empty? pq))
      (let* ([curr (mutable-priority-queue-remove! pq)]
             [d (car curr)]
             [u (cadr curr)])
        (when (> d (vector-ref dist u))
          (continue))
        (for ([neighbor (vector-ref adj u)])
          (let ([v (car neighbor)]
                [w (cadr neighbor)])
            (let ([new-dist (+ d w)])
              (when (< new-dist (vector-ref dist v))
                (vector-set! dist v new-dist)
                (mutable-priority-queue-add! pq (list new-dist v))))))))
    dist)

  (define (solve)
    (let loop ([unknown-edges unknown-edges])
      (cond
        [(null? unknown-edges)
         (let ([dist (vector-ref (dijkstra adj source) destination)])
           (if (= dist target)
               #t
               #f))]
        [else
         (let ([edge (car unknown-edges)]
               [u (car edge)]
               [v (cadr edge)])
           (vector-set! adj u (filter (lambda (x) (not (= (car x) v))) (vector-ref adj u)))
           (vector-set! adj v (filter (lambda (x) (not (= (car x) u))) (vector-ref adj v)))
           (vector-set! adj u (cons (list v 1) (vector-ref adj u)))
           (vector-set! adj v (cons (list u 1) (vector-ref adj v)))
           (if (solve)
               #t
               (begin
                 (vector-set! adj u (filter (lambda (x) (not (= (car x) v))) (vector-ref adj u)))
                 (vector-set! adj v (filter (lambda (x) (not (= (car x) u))) (vector-ref adj v)))
                 (vector-set! adj u (cons (list v (+ target 1)) (vector-ref adj u)))
                 (vector-set! adj v (cons (list u (+ target 1)) (vector-ref adj v)))
                 (let ([dist-before (vector-ref (dijkstra adj source) destination)])
                   (if (>= dist-before target)
                       #f
                       (begin
                         (vector-set! adj u (filter (lambda (x) (not (= (car x) v))) (vector-ref adj u)))
                         (vector-set! adj v (filter (lambda (x) (not (= (car x) u))) (vector-ref adj v)))
                         (vector-set! adj u (cons (list v (max 1 (- target (- dist-before 1)))) (vector-ref adj u)))
                         (vector-set! adj v (cons (list u (max 1 (- target (- dist-before 1)))) (vector-ref adj v)))
                         (let ([dist-after (vector-ref (dijkstra adj source) destination)])
                           (if (= dist-after target)
                               #t
                               #f)))))))))
        (loop (cdr unknown-edges))))))

  (if (not (solve))
      '()
      (begin
        (for ([edge edges] [i (in-range (length edges))])
          (let ([u (car edge)]
                [v (cadr edge)]
                [w (caddr edge)])
            (when (= w -1)
              (vector-set! adj u (filter (lambda (x) (not (= (car x) v))) (vector-ref adj u)))
              (vector-set! adj v (filter (lambda (x) (not (= (car x) u))) (vector-ref adj v)))
              (let ([dist-before (vector-ref (dijkstra adj source) destination)])
                (when (>= dist-before target)
                  (vector-set! adj u (cons (list v 1)) (vector-ref adj u))
                  (vector-set! adj v (cons (list u 1)) (vector-ref adj v))
                  (set! (list-ref edges i) (list u v 1)))
                (when (< dist-before target)
                  (vector-set! adj u (cons (list v (max 1 (- target (- dist-before 1))))) (vector-ref adj u))
                  (vector-set! adj v (cons (list u (max 1 (- target (- dist-before 1))))) (vector-ref adj v))
                  (set! (list-ref edges i) (list u v (max 1 (- target (- dist-before 1)))))))))
        edges)))