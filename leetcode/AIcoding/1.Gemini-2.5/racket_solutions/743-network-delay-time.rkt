#lang racket

(require racket/hash)
(require racket/heap)

(define (network-delay-time times n k)
  (define graph (make-hash))
  (for-each (lambda (edge)
              (define u (first edge))
              (define v (second edge))
              (define w (third edge))
              (hash-update! graph u (lambda (lst) (cons (list v w) lst)) '()))
            times)

  (define dist (make-hash))
  (for-each (lambda (i) (hash-set! dist i +inf.0)) (range 1 (+ n 1)))
  (hash-set! dist k 0)

  (define pq (make-heap (lambda (a b) (< (first a) (first b)))))
  (heap-add! pq (list 0 k))

  (while (not (heap-empty? pq))
    (define current-item (heap-remove-min! pq))
    (define current-time (first current-item))
    (define current-node (second current-item))

    (when (> current-time (hash-ref dist current-node))
      (void))

    (for-each (lambda (neighbor-edge)
                (define neighbor-node (first neighbor-edge))
                (define weight (second neighbor-edge))
                (define new-time (+ current-time weight))

                (when (< new-time (hash-ref dist neighbor-node))
                  (hash-set! dist neighbor-node new-time)
                  (heap-add! pq (list new-time neighbor-node))))
              (hash-ref graph current-node '())))

  (define max-delay 0)
  (define all-reachable? #t)
  (for-each (lambda (i)
              (define d (hash-ref dist i))
              (when (= d +inf.0)
                (set! all-reachable? #f))
              (when (> d max-delay)
                (set! max-delay d)))
            (range 1 (+ n 1)))

  (if all-reachable? max-delay -1))