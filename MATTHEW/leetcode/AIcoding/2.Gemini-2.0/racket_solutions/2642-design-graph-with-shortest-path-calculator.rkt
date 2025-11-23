(define (make-graph n edges)
  (let ((adj-list (make-vector n '())))
    (for-each (lambda (edge)
                (let ((u (car edge))
                      (v (cadr edge))
                      (w (caddr edge)))
                  (vector-set! adj-list u (cons (list v w) (vector-ref adj-list u)))))
              edges)
    (list adj-list)))

(define (add-edge! graph edge)
  (let* ((adj-list (car graph))
         (u (car edge))
         (v (cadr edge))
         (w (caddr edge)))
    (vector-set! adj-list u (cons (list v w) (vector-ref adj-list u)))
    graph))

(define (shortest-path graph start end)
  (let* ((adj-list (car graph))
         (n (vector-length adj-list))
         (dist (make-vector n #inf))
         (visited (make-vector n #f))
         (pq (list (list 0 start))))
    (vector-set! dist start 0)
    (letrec ((dijkstra
              (lambda (pq)
                (cond
                  ((null? pq) #inf)
                  (else
                   (let* ((curr (car pq))
                          (d (car curr))
                          (u (cadr curr)))
                     (if (vector-ref visited u)
                         (dijkstra (cdr pq))
                         (begin
                           (vector-set! visited u #t)
                           (for-each (lambda (neighbor)
                                       (let ((v (car neighbor))
                                             (w (cadr neighbor)))
                                         (if (< (+ d w) (vector-ref dist v))
                                             (begin
                                               (vector-set! dist v (+ d w))
                                               (set! pq (insert (list (+ d w) v) (cdr pq))))))
                                     (vector-ref adj-list u))
                           (dijkstra (cdr pq))))))))
             (insert
              (lambda (item lst)
                (cond
                  ((null? lst) (list item))
                  (else
                   (if (< (car item) (car (car lst)))
                       (cons item lst)
                       (cons (car lst) (insert item (cdr lst)))))))))
      (let ((result (dijkstra pq)))
        (if (= result #inf)
            -1
            (vector-ref dist end))))))

(define Graph
  (class object%
    (init n edges)
    (super-new)
    (define adj-list (make-graph n edges))
    (define num-nodes n)
    (public
     (define (add-edge u v w)
       (set! adj-list (add-edge! adj-list (list u v w))))
     (define (shortest-path start end)
       (shortest-path adj-list start end)))))