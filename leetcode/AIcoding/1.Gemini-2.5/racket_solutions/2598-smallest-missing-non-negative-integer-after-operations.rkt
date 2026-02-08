(define (smallest-missing-non-negative-integer-after-operations nums value)
  (let* ([freq (make-vector value 0)]) ; Initialize frequency vector of size 'value' with zeros

    ; Populate frequency vector with counts of num % value
    (for-each (lambda (num)
                (let ([remainder (modulo num value)])
                  (vector-set! freq remainder (+ (vector-ref freq remainder) 1))))
              nums)

    ; Find the smallest non-negative integer k that cannot be formed
    (let loop ([k 0])
      (let ([remainder (modulo k value)])
        (if (> (vector-ref freq remainder) 0)
            ; If there's an available number that maps to 'remainder', use it and try to form k+1
            (begin
              (vector-set! freq remainder (- (vector-ref freq remainder) 1))
              (loop (+ k 1)))
            ; Otherwise, 'k' cannot be formed, so it is the smallest missing non-negative integer
            k)))))