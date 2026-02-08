(define-struct NumArray
  ([sums #:mutable]))

(define (numArray-new nums)
  (let* ([n (length nums)]
         [sums (make-vector (+ n 1) 0)])
    (for ([i (in-range n)])
      (vector-set! sums (+ i 1) (+ (vector-ref sums i) (list-ref nums i))))
    (make-NumArray sums)))

(define (numArray-sumRange obj left right)
  (let ([sums (NumArray-sums obj)])
    (- (vector-ref sums (+ right 1)) (vector-ref sums left))))