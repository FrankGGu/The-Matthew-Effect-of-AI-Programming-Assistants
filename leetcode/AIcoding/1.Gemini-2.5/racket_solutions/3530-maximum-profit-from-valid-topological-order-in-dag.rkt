#lang racket

(require data/queue)

(define (maximum-profit-from-valid-topological-order-in-dag n edges profits)
  (define adj (make-hash))
  (define in-degree (make-hash))

  (for ([i (range n)])
    (hash-set! adj i '())
    (hash-set! in-degree i 0))

  (for ([edge edges])
    (define u (car edge))
    (define v (cadr edge))
    (hash-update! adj u (lambda (lst) (cons v lst)))
    (hash-update! in-degree v add1))

  (define dp (make-vector n))
  (for ([i (range n)])
    (vector-set! dp i (list-ref profits i)))

  (define q (make-queue))
  (for ([i (range n)])
    (when (= (hash-ref in-degree i) 0)
      (enqueue! q i)))

  (define max-profit 0)

  (while (not (queue-empty? q))
    (define u (dequeue! q))

    (set! max-profit (max max-profit (vector-ref dp u)))

    (for ([v (hash-ref adj u)])
      (vector-set! dp v (max (vector-ref dp v)
                             (+ (vector-ref dp u) (list-ref profits v))))
      (hash-update! in-degree v sub1)
      (when (= (hash-ref in-degree v) 0)
        (enqueue! q v))))

  max-profit)