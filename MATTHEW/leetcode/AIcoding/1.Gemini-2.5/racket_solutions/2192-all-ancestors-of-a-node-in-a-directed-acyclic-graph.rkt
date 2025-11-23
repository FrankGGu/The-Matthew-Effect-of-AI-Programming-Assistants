#lang racket
(require data/queue)
(require data/set)

(define (get-all-ancestors n edges)
  (define reversed-adj (make-vector n null))
  (for-each (lambda (edge)
              (define u (car edge))
              (define v (cadr edge))
              (vector-set! reversed-adj v (cons u (vector-ref reversed-adj v))))
            edges)

  (define result (make-vector n null))

  (for i (in-range n)
    (define ancestors-for-i (set))
    (define q (make-queue))
    (define visited (make-vector n #f))

    (queue-add! q i)
    (vector-set! visited i #t)

    (let loop ()
      (when (not (queue-empty? q))
        (define current-node (queue-remove! q))

        (for-each (lambda (neighbor)
                    (when (not (vector-ref visited neighbor))
                      (vector-set! visited neighbor #t)
                      (set-add! ancestors-for-i neighbor)
                      (queue-add! q neighbor)))
                  (vector-ref reversed-adj current-node))
        (loop)))

    (vector-set! result i (sort (set->list ancestors-for-i) <)))

  (vector->list result))