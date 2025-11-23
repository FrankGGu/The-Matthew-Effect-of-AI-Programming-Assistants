(define (sum-of-subarray-mins arr)
  (define mod 1000000007)
  (define n (length arr))
  (define left (make-vector n 0))
  (define right (make-vector n 0))

  (define stack '())

  (for ([i (in-range n)])
    (begin
      (while (and (not (null? stack)) (> (vector-ref arr (car stack)) (vector-ref arr i)))
        (set! stack (cdr stack)))
      (vector-set! left i (if (null? stack) (add1 i) (- i (car stack))))
      (set! stack (cons i stack))))

  (set! stack '())

  (for ([i (in-range (sub1 n) -1 -1)])
    (begin
      (while (and (not (null? stack)) (>= (vector-ref arr (car stack)) (vector-ref arr i)))
        (set! stack (cdr stack)))
      (vector-set! right i (if (null? stack) (add1 (- n i)) (- (car stack) i)))
      (set! stack (cons i stack))))

  (define result 0)

  (for ([i (in-range n)])
    (set! result (modulo (+ result (* (vector-ref arr i) (vector-ref left i) (vector-ref right i))) mod)))

  result)