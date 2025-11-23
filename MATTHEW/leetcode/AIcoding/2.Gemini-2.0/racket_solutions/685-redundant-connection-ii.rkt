(define (find-redundant-directed-connection edges)
  (define n (add1 (apply max (append* edges))))
  (define parents (make-vector n 0))
  (define conflict '())
  (define cycle '())

  (for ([i (range 0 (length edges))])
    (define u (first (list-ref edges i)))
    (define v (second (list-ref edges i)))
    (cond
      [(not (= (vector-ref parents v) 0))
       (set! conflict (list u v))]
      [else
       (vector-set! parents v u)]))

  (define (find root)
    (define path '())
    (define (find-path current)
      (cond
        [(= current 0) #f]
        [(member current path) (cons current path)]
        [else
         (set! path (cons current path))
         (find-path (vector-ref parents current))]))
    (find-path root))

  (define root (for/first ([i (range 1 n)] #:when (= (vector-ref parents i) 0)) i))
  (when (not root) (set! root 1))

  (define cycle-path (find root))
  (when cycle-path (set! cycle (list (car (last cycle-path)) (car cycle-path))))

  (cond
    [(and (not (null? conflict)) (not (null? cycle)))
     (for/first ([i (reverse (range 0 (length edges)))] #:when (equal? (list-ref edges i 1) (second conflict)) (list-ref edges i))]
    [(not (null? conflict))
     conflict]
    [else
     (for/first ([i (reverse (range 0 (length edges)))] #:when (equal? (list-ref edges i 0) (first cycle)) #:when (equal? (list-ref edges i 1) (second cycle)) (list-ref edges i))]))