#lang racket

(define (max-subarray-min-product nums)
  (define n (length nums))
  (define mod (expt 10 9))

  (define left (make-vector n 0))
  (define right (make-vector n 0))

  (define stack '())

  (for ([i (in-range n)])
    (while (and (not (null? stack)) (> (vector-ref nums (car stack)) (vector-ref nums i)))
      (set! stack (cdr stack)))
    (vector-set! left i (if (null? stack) -1 (car stack)))
    (set! stack (cons i stack)))

  (set! stack '())

  (for ([i (in-range (sub1 n) -1 -1)])
    (while (and (not (null? stack)) (> (vector-ref nums (car stack)) (vector-ref nums i)))
      (set! stack (cdr stack)))
    (vector-set! right i (if (null? stack) n (car stack)))
    (set! stack (cons i stack)))

  (define max-product 0)

  (for ([i (in-range n)])
    (define min-val (vector-ref nums i))
    (define sum (modulo (* min-val (foldl + 0 (for/list ([j (in-range (1+ (- (vector-ref right i) (vector-ref left i))))]
                                                (if (and (>= j 1) (<= j (- (vector-ref right i) (vector-ref left i))))
                                                    (vector-ref nums (+ i j -1)) 0)))))
    (set! max-product (max max-product sum)))

  (modulo max-product mod))

(max-subarray-min-product '(1 2 3 2))