(define-struct Accumulator (total))

(define (Accumulator.0)
  (make-Accumulator 0))

(define (add acc x)
  (set-Accumulator-total! acc (+ (Accumulator-total acc) x)))

(define (getTotal acc)
  (Accumulator-total acc))