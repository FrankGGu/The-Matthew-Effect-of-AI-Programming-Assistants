#lang racket
(require racket/queue)

(define (topological-sort k conditions)
  (define adj (make-hash))
  (define in-degree (make-vector (+ k 1) 0))

  (for ([i (range 1 (+ k 1))])
    (hash-set! adj i '()))

  (for ([cond conditions])
    (define u (car cond))
    (define v (cadr cond))
    (hash-set! adj u (cons v (hash-ref adj u)))
    (vector-set! in-degree v (+ (vector-ref in-degree v) 1)))

  (define q (make-queue))
  (for ([i (range 1 (+ k 1))])
    (when (= (vector-ref in-degree i) 0)
      (enqueue! q i)))

  (define node-to-index (make-vector (+ k 1) 0))
  (define current-index 0)
  (define visited-nodes-count 0)

  (while (not (queue-empty? q))
    (define u (dequeue! q))
    (vector-set! node-to-index u current-index)
    (set! current-index (+ current-index 1))
    (set! visited-nodes-count (+ visited-nodes-count 1))

    (for ([v (hash-ref adj u)])
      (vector-set! in-degree v (- (vector-ref in-degree v) 1))
      (when (= (vector-ref in-degree v) 0)
        (enqueue! q v))))

  (if (= visited-nodes-count k)
      node-to-index
      #f))

(define (build-matrix k row-conditions col-conditions)
  (define row-order (topological-sort k row-conditions))
  (unless row-order
    (list))

  (define col-order (topological-sort k col-conditions))
  (unless col-order
    (list))

  (define matrix (build-vector k (lambda (x) (build-vector k (lambda (y) 0)))))

  (for ([num (range 1 (+ k 1))])
    (define r (vector-ref row-order num))
    (define c (vector-ref col-order num))
    (vector-set! (vector-ref matrix r) c num))

  (map vector->list (vector->list matrix)))