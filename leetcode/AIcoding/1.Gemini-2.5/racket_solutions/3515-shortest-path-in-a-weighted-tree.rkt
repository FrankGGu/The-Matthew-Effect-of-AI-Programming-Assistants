#lang racket

(require data/heap)

(define (shortest-path-weighted-tree n edges source destination)
  (define graph (make-hash))
  (for ([i (in-range n)])
    (hash-set! graph i '()))

  (for ([edge edges])
    (define u (car edge))
    (define v (cadr edge))
    (define w (caddr edge))
    (hash-set! graph u (cons (list v w) (hash-ref graph u)))
    (hash-set! graph v (cons (list u w) (hash-ref graph v))))

  (define distances (make-hash))
  (define +infinity (add1 (expt 10 9)))

  (for ([i (in-range n)])
    (hash-set! distances i +infinity))
  (hash-set! distances source 0)

  (define pq (heap-make (lambda (a b) (< (car a) (car b)))))
  (heap-add! pq (list 0 source))

  (while (not (heap-empty? pq))
    (define current-item (heap-min pq))
    (heap-remove-min! pq)

    (define d (car current-item))
    (define u (cadr current-item))

    (unless (> d (hash-ref distances u))
      (for ([neighbor-info (hash-ref graph u)])
        (define v (car neighbor-info))
        (define weight (cadr neighbor-info))

        (when (< (+ d weight) (hash-ref distances v))
          (hash-set! distances v (+ d weight))
          (heap-add! pq (list (+ d weight) v))))))

  (define result (hash-ref distances destination))
  (if (= result +infinity)
      -1
      result))