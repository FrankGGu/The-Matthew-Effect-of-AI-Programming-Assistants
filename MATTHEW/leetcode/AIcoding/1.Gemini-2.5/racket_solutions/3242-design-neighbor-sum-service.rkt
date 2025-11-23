#lang racket

(struct neighbor-sum-service (nums tree n) #:mutable)

(define (make-neighbor-sum-service num-list)
  (define nums (list->vector num-list))
  (define n (vector-length nums))
  (define tree (make-vector (* 4 n) 0))

  (define (build node start end)
    (cond
      [(= start end)
       (vector-set! tree node (vector-ref nums start))]
      [else
       (define mid (quotient (+ start end) 2))
       (build (* 2 node) start mid)
       (build (+ (* 2 node) 1) (+ mid 1) end)
       (vector-set! tree node (+ (vector-ref tree (* 2 node)) (vector-ref tree (+ (* 2 node) 1))))]))

  (build 1 0 (- n 1))
  (neighbor-sum-service nums tree n))

(define (neighbor-sum-service-update! service index val)
  (define tree (neighbor-sum-service-tree service))
  (define n (neighbor-sum-service-n service))

  (define (update-tree node start end)
    (cond
      [(= start end)
       (vector-set! tree node val)]
      [else
       (define mid (quotient (+ start end) 2))
       (if (<= index mid)
           (update-tree (* 2 node) start mid)
           (update-tree (+ (* 2 node) 1) (+ mid 1) end))
       (vector-set! tree node (+ (vector-ref tree (* 2 node)) (vector-ref tree (+ (* 2 node) 1))))]))

  (update-tree 1 0 (- n 1)))

(define (neighbor-sum-service-sum-range service left right)
  (define tree (neighbor-sum-service-tree service))
  (define n (neighbor-sum-service-n service))

  (define (query-tree node start end)
    (cond
      [(or (> start right) (< end left))
       0]
      [(and (>= start left) (<= end right))
       (vector-ref tree node)]
      [else
       (define mid (quotient (+ start end) 2))
       (+ (query-tree (* 2 node) start mid)
          (query-tree (+ (* 2 node) 1) (+ mid 1) end))]))

  (query-tree 1 0 (- n 1)))