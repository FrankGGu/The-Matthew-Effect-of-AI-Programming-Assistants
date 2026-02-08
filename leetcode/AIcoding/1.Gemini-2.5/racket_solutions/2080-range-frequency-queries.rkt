#lang racket

(struct range-frequency-queries (val->indices-map))

(define (make-range-frequency-queries arr)
  (let ([val->indices-map (make-hash)])
    (for ([idx (in-naturals)]
          [val (in-list arr)])
      (hash-update! val->indices-map val
                    (lambda (lst) (cons idx lst))
                    '()))
    (for ([(val indices-list) (in-hash val->indices-map)])
      (hash-set! val->indices-map val (list->vector (sort indices-list <))))
    (range-frequency-queries val->indices-map)))

(define (range-frequency-queries-query this left right value)
  (let ([indices-vec (hash-ref (range-frequency-queries-val->indices-map this) value #f)])
    (if (not indices-vec)
        0
        (- (sequence-bisect-right indices-vec right)
           (sequence-bisect-left indices-vec left)))))