#lang racket

(define (num-submatrix-sum-less-than-k matrix k)
  (define (sum-rect top left bottom right)
    (if (and (>= top 0) (>= left 0) (< bottom (length matrix)) (< right (length (car matrix))))
        (let loop ((i top) (j left) (s 0))
          (if (= i bottom)
              s
              (loop (add1 i) j (+ s (for/sum ([l (in-range left right)])
                                       (list-ref (list-ref matrix i) l))))))
        0))

  (define (count-submatrices)
    (define count 0)
    (for ((top (in-range (length matrix)))
          (bottom (in-range top (length matrix)))
          (left (in-range (length (car matrix)))
                (right (in-range left (length (car matrix)))))
          #:when (< (sum-rect top left bottom right) k))
      (set! count (add1 count)))
    count)

  (count-submatrices))

(define matrix '((1 0 1) (0 -2 3) (1 2 3)))
(define k 2)
(num-submatrix-sum-less-than-k matrix k)