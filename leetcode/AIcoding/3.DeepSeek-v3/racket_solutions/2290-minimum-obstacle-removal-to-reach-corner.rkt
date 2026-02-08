#lang racket

(require data/heap)

(define (minimum-obstacles grid)
  (define m (length grid))
  (define n (if (zero? m) 0 (length (car grid))))
  (define dirs '((0 1) (1 0) (0 -1) (-1 0)))
  (define pq (make-heap (lambda (a b) (<= (car a) (car b)))))
  (define dist (make-vector (* m n) +inf.0))
  (vector-set! dist 0 (list-ref (list-ref grid 0) 0))
  (heap-add! pq (cons (vector-ref dist 0) 0))

  (let loop ()
    (if (heap-empty? pq)
        (vector-ref dist (sub1 (* m n)))
        (let* ([current (heap-min pq)]
               [cost (car current)]
               [pos (cdr current)]
               [i (quotient pos n)]
               [j (remainder pos n)])
          (heap-remove! pq)
          (when (= cost (vector-ref dist pos))
            (for ([dir dirs])
              (let* ([ni (+ i (car dir))]
                     [nj (+ j (cadr dir))])
                (when (and (>= ni 0) (< ni m) (>= nj 0) (< nj n))
                  (let* ([new-pos (+ (* ni n) nj)]
                         [new-cost (+ cost (list-ref (list-ref grid ni) nj))])
                    (when (< new-cost (vector-ref dist new-pos))
                      (vector-set! dist new-pos new-cost)
                      (heap-add! pq (cons new-cost new-pos))))))))
          (loop))))