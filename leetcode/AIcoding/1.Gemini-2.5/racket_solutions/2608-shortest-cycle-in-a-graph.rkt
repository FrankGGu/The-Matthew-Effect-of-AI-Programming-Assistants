#lang racket

(require racket/vector)
(require racket/queue)

(define (shortest-cycle n edges)
  (define adj (make-vector n null))
  (for-each
   (lambda (edge)
     (define u (car edge))
     (define v (cadr edge))
     (vector-set! adj u (cons v (vector-ref adj u)))
     (vector-set! adj v (cons u (vector-ref adj v))))
   edges)

  (define min-cycle-len +inf.0)

  (for ([start-node (in-range n)])
    (define dist (make-vector n +inf.0))
    (define parent (make-vector n -1))

    (define q (make-queue))
    (queue-put! q start-node)
    (vector-set! dist start-node 0)

    (while (not (queue-empty? q))
      (define u (queue-get! q))

      (for-each
       (lambda (v)
         (cond
           ((= v (vector-ref parent u))
            #f)
           ((not (= (vector-ref dist v) +inf.0))
            (set! min-cycle-len (min min-cycle-len (+ (vector-ref dist u) (vector-ref dist v) 1))))
           (else
            (vector-set! dist v (+ (vector-ref dist u) 1))
            (vector-set! parent v u)
            (queue-put! q v))))
       (vector-ref adj u))))

  (if (= min-cycle-len +inf.0)
      -1
      (inexact->exact min-cycle-len)))