(require racket/list
         racket/queue)

(define (maximum-safeness-factor grid)
  (define n (vector-length grid))
  (define m (vector-length (vector-ref grid 0)))

  (define (bfs)
    (define dist (make-vector n (lambda (i) (make-vector m (lambda (j) #f)))))
    (define q (make-queue))

    (for ([i (in-range n)]
          [j (in-range m)])
      (when (= (vector-ref (vector-ref grid i) j) 1)
        (vector-set! (vector-ref dist i) j 0)
        (enqueue! q (cons i j))))

    (define dirs '((-1 . 0) (1 . 0) (0 . -1) (0 . 1)))

    (define (valid? r c)
      (and (>= r 0) (< r n) (>= c 0) (< c m)))

    (define (update-distances)
      (unless (queue-empty? q)
        (let* ([curr (dequeue! q)]
               [r (car curr)]
               [c (cdr curr)])
          (for ([dir (in-list dirs)])
            (let* ([nr (+ r (car dir))]
                   [nc (+ c (cdr dir))])
              (when (and (valid? nr nc) (not (vector-ref (vector-ref dist nr) nc)))
                (vector-set! (vector-ref dist nr) nc (+ 1 (vector-ref (vector-ref dist r) c)))
                (enqueue! q (cons nr nc))))))
        (update-distances)))

    (update-distances)
    dist)

  (define dist (bfs))

  (define (binary-search low high)
    (cond
      [(> low high) low]
      [else
       (let ([mid (floor (+ low high) 2)])
         (if (can-reach? mid)
             (binary-search (+ mid 1) high)
             (binary-search low (- mid 1))))]))

  (define (can-reach? threshold)
    (define visited (make-vector n (lambda (i) (make-vector m (lambda (j) #f)))))
    (define q (make-queue))
    (vector-set! (vector-ref visited 0) 0 #t)
    (enqueue! q (cons 0 0))

    (define dirs '((-1 . 0) (1 . 0) (0 . -1) (0 . 1)))

    (define (valid? r c)
      (and (>= r 0) (< r n) (>= c 0) (< c m)))

    (define (explore)
      (unless (queue-empty? q)
        (let* ([curr (dequeue! q)]
               [r (car curr)]
               [c (cdr curr)])
          (when (and (= r (- n 1)) (= c (- m 1)))
            (return #t))
          (for ([dir (in-list dirs)])
            (let* ([nr (+ r (car dir))]
                   [nc (+ c (cdr dir))])
              (when (and (valid? nr nc)
                         (>= (vector-ref (vector-ref dist nr) nc) threshold)
                         (not (vector-ref (vector-ref visited nr) nc)))
                (vector-set! (vector-ref visited nr) nc #t)
                (enqueue! q (cons nr nc))))))
        (explore))
      #f)

    (if (>= (vector-ref (vector-ref dist 0) 0) threshold)
        (explore)
        #f))

  (let ([max-dist (min (vector-ref (vector-ref dist 0) 0) (vector-ref (vector-ref dist (- n 1)) (- m 1)))])
    (if (not max-dist)
        -1
        (- (binary-search 0 (+ max-dist 1)) 1))))