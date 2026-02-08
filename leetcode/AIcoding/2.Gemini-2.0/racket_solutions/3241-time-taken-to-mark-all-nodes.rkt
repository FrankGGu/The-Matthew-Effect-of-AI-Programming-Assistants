(define (time-taken nodes edges start)
  (let* ((n (length nodes))
         (adj (make-vector n '()))
         (visited (make-vector n #f))
         (dist (make-vector n #f)))
    (for ((edge edges))
      (let ((u (car edge))
            (v (cadr edge))
            (w (caddr edge)))
        (vector-set! adj u (cons (cons v w) (vector-ref adj u)))
        (vector-set! adj v (cons (cons u w) (vector-ref adj v)))))

    (define (dijkstra start)
      (let ((pq (list (cons 0 start))))
        (vector-set! dist start 0)
        (define (loop pq)
          (cond
            [(null? pq) #t]
            [else
             (let* ((curr (car pq))
                    (d (car curr))
                    (u (cdr curr)))
               (if (vector-ref! visited u)
                   (loop (cdr pq))
                   (begin
                     (vector-set! visited u #t)
                     (for ((neighbor (vector-ref adj u)))
                       (let ((v (car neighbor))
                             (w (cdr neighbor)))
                         (if (or (not (vector-ref! dist v)) (> (+ d w) (vector-ref! dist v)))
                             (vector-set! dist v (+ d w))
                             #t))
                       (define (insert-pq pq v w)
                         (cond
                           [(null? pq) (list (cons w v))]
                           [(< w (car (car pq))) (cons (cons w v) pq)]
                           [else (cons (car pq) (insert-pq (cdr pq) v w))]))
                       (set! pq (sort (append (cdr pq) (map (lambda (x) (cons (vector-ref! dist (car x)) (car x))) (filter (lambda (x) (not (vector-ref! visited (car x)))) (map car (vector-ref adj u))))) (lambda (a b) (< (car a) (car b)))))))
                     (loop (cdr pq))))]))
        (loop pq)))

    (dijkstra start)
    (let ((max-time 0))
      (for ((i (in-range n)))
        (if (vector-ref! dist i)
            (set! max-time (max max-time (vector-ref! dist i)))
            #t))
      max-time)))