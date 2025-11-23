#lang racket
(require data/heap)

(define (total-cost costs k candidates)
  (define costs-vec (list->vector costs))
  (define n (vector-length costs-vec))
  (define total-cost-sum 0)

  (define (heap-comp a b)
    (or (< (car a) (car b))
        (and (= (car a) (car b))
             (< (cadr a) (cadr b)))))

  (define left-pq (make-heap heap-comp))
  (define right-pq (make-heap heap-comp))

  (define left-ptr 0)
  (define right-ptr (- n 1))

  (for ([_ (in-range candidates)])
    (when (<= left-ptr right-ptr)
      (heap-insert! left-pq (list (vector-ref costs-vec left-ptr) left-ptr))
      (set! left-ptr (+ left-ptr 1))))

  (for ([_ (in-range candidates)])
    (when (<= left-ptr right-ptr)
      (heap-insert! right-pq (list (vector-ref costs-vec right-ptr) right-ptr))
      (set! right-ptr (- right-ptr 1))))

  (for ([_ (in-range k)])
    (define min-left-val (if (heap-empty? left-pq) #f (heap-min left-pq)))
    (define min-right-val (if (heap-empty? right-pq) #f (heap-min right-pq)))

    (cond
      [(and min-left-val (not min-right-val))
       (set! total-cost-sum (+ total-cost-sum (car min-left-val)))
       (heap-extract-min! left-pq)
       (when (<= left-ptr right-ptr)
         (heap-insert! left-pq (list (vector-ref costs-vec left-ptr) left-ptr))
         (set! left-ptr (+ left-ptr 1)))]

      [(and (not min-left-val) min-right-val)
       (set! total-cost-sum (+ total-cost-sum (car min-right-val)))
       (heap-extract-min! right-pq)
       (when (<= left-ptr right-ptr)
         (heap-insert! right-pq (list (vector-ref costs-vec right-ptr) right-ptr))
         (set! right-ptr (- right-ptr 1)))]

      [(and min-left-val min-right-val)
       (if (heap-comp min-left-val min-right-val)
           (begin
             (set! total-cost-sum (+ total-cost-sum (car min-left-val)))
             (heap-extract-min! left-pq)
             (when (<= left-ptr right-ptr)
               (heap-insert! left-pq (list (vector-ref costs-vec left-ptr) left-ptr))
               (set! left-ptr (+ left-ptr 1))))
           (begin
             (set! total-cost-sum (+ total-cost-sum (car min-right-val)))
             (heap-extract-min! right-pq)
             (when (<= left-ptr right-ptr)
               (heap-insert! right-pq (list (vector-ref costs-vec right-ptr) right-ptr))
               (set! right-ptr (- right-ptr 1)))))]
      [else #f]))

  total-cost-sum)