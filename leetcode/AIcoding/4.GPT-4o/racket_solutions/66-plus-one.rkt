(define (plus-one digits)
  (let loop ((digits (reverse digits)) (carry 1) (result '()))
    (if (null? digits)
        (if (= carry 1) (cons 1 (reverse result)) (reverse result))
        (let ((sum (+ (car digits) carry)))
          (loop (cdr digits) (if (= sum 10) 1 0) (cons (modulo sum 10) result)))))))

(plus-one '(1 2 3)) ; Example usage