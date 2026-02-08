#lang racket

(require data/heap)

(define/contract (kth-nearest queries obstacles k)
  (-> (listof (listof exact-integer?)) (listof (listof exact-integer?)) exact-integer? (listof exact-integer?))
  (define (distance p q)
    (+ (abs (- (car p) (car q))) (abs (- (cadr p) (cadr q)))))

  (define (process-query query)
    (define x (car query))
    (define y (cadr query))
    (define heap (make-heap (lambda (a b) (< (car a) (car b)))))
    (for ([obstacle (in-list obstacles)])
      (define dist (distance obstacle (list x y)))
      (heap-add! heap (cons dist obstacle))
      (when (> (heap-count heap) k)
        (heap-remove-min! heap)))
    (if (zero? (heap-count heap))
        -1
        (distance (heap-min heap) (list x y))))

  (map process-query queries))