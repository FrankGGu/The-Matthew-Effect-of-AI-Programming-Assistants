#lang racket

(require data/heap)

(define (swim-in-rising-water grid-list)
  (define n (length grid-list))

  (define grid (make-vector n))
  (for ([i (in-range n)])
    (vector-set! grid i (list->vector (list-ref grid-list i))))

  (define (in-bounds? r c)
    (and (>= r 0) (< r n) (>= c 0) (< c n)))

  (define dist (make-vector n))
  (for ([i (in-range n)])
    (vector-set! dist i (make-vector n +inf.0)))

  (define pq (make-heap (lambda (a b) (< (car a) (car b)))))

  (heap-add! pq (list (vector-ref (vector-ref grid 0) 0) 0 0))
  (vector-set! (vector-ref dist 0) 0 (vector-ref (vector-ref grid 0) 0))

  (define dr (list 0 0 1 -1))
  (define dc (list 1 -1 0 0))

  (let loop ()
    (when (not (heap-empty? pq))
      (define current (heap-min pq))
      (heap-remove-min! pq)

      (define t (car current))
      (define r (cadr current))
      (define c (caddr current))

      (when (> t (vector-ref (vector-ref dist r) c))
        (loop))

      (when (and (= r (- n 1)) (= c (- n 1)))
        t)

      (for ([i (in-range 4)])
        (define nr (+ r (list-ref dr i)))
        (define nc (+ c (list-ref dc i)))

        (when (in-bounds? nr nc)
          (define new-t (max t (vector-ref (vector-ref grid nr) nc)))
          (when (< new-t (vector-ref (vector-ref dist nr) nc))
            (vector-set! (vector-ref dist nr) nc new-t)
            (heap-add! pq (list new-t nr nc)))))
      (loop))))