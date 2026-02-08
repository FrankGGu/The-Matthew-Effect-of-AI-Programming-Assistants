#lang racket

(define (searchMatrix matrix target)
  (define (binary-search row)
    (define (helper left right)
      (if (> left right)
          #f
          (let* ((mid (quotient (+ left right) 2))
                 (mid-val (vector-ref (vector-ref matrix row) mid)))
            (cond
              ((= mid-val target) #t)
              ((< mid-val target) (helper (+ mid 1) right))
              (else (helper left (- mid 1)))))))
    (helper 0 (sub1 (vector-length (vector-ref matrix row)))))

  (define (search-rows)
    (for/fold ([found #f]) ([i (in-range (vector-length matrix))])
      (if (and (not found) (<= (vector-ref (vector-ref matrix i) 0) target)
               (>= (vector-ref (vector-ref matrix i) (sub1 (vector-length (vector-ref matrix i)))) target))
          (binary-search i)
          found)))

  (if (zero? (vector-length matrix)) #f (search-rows))
)