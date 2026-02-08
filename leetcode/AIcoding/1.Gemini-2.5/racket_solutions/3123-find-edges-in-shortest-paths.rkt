#lang racket

(require data/heap)

(define +infinity+ (expt 10 18))

(define (dijkstra n graph start-node)
  (define distances (make-vector n +infinity+))
  (vector-set! distances start-node 0)

  (define pq (make-heap (lambda (a b) (< (car a) (car b)))))
  (heap-add! pq (cons 0 start-node))

  (let loop ()
    (when (not (heap-empty? pq))
      (define current-pair (heap-min-key pq))
      (heap-remove-min! pq)

      (define current-dist (car current-pair))
      (define u (cdr current-pair))

      (when (<= current-dist (vector-ref distances u))
        (for-each
         (lambda (edge)
           (define v (car edge))
           (define weight (cdr edge))
           (when (< (+ current-dist weight) (vector-ref distances v))
             (vector-set! distances v (+ current-dist weight))
             (heap-add! pq (cons (vector-ref distances v) v))))
         (vector-ref graph u)))
      (loop)))
  distances)

(define (find-edges-in-shortest-paths n edges)
  (define adj (make-vector n '()))
  (define rev-adj (make-vector n '()))

  (for-each
   (lambda (edge)
     (define u (car edge))
     (define v (cadr edge))
     (define w (caddr edge))
     (vector-set! adj u (cons (cons v w) (vector-ref adj u)))
     (vector-set! rev-adj v (cons (cons u w) (vector-ref rev-adj v))))
   edges)

  (define dist-from-src (dijkstra n adj 0))
  (define dist-to-target (dijkstra n rev-adj (- n 1)))

  (define shortest-path-len (vector-ref dist-from-src (- n 1)))
  (define result '())

  (for-each
   (lambda (edge)
     (define u (car edge))
     (define v (cadr edge))
     (define w (caddr edge))

     (when (and
            (not (= (vector-ref dist-from-src u) +infinity+))
            (not (= (vector-ref dist-to-target v) +infinity+))
            (= (+ (vector-ref dist-from-src u) w (vector-ref dist-to-target v))
               shortest-path-len))
       (set! result (cons (list u v) result))))
   edges)

  (reverse result))