(define (divisibility-array num m)
  (let* ([n (string-length num)]
         [divisibility-arr (make-vector n 0)]
         [remainder 0])
    (for ([i (in-range n)])
      (set! remainder (modulo (+ (* 10 remainder) (string->number (substring num i (+ i 1)))) m))
      (if (zero? remainder)
          (vector-set! divisibility-arr i 1)
          (vector-set! divisibility-arr i 0)))
    divisibility-arr))