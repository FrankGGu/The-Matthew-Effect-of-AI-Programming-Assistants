(define (num-subarray-bounded-max A L U)
  (define (count-bound max)
    (let loop ((count 0) (result 0) (length 0))
      (cond
        ((null? max) result)
        ((> (car max) U) (loop (1+ count) result 0))
        ((< (car max) L) (loop count (+ result length) (1+ length)))
        (else (loop (1+ count) (+ result length) (1+ length))))))
  (- (count-bound A) (count-bound (filter (lambda (x) (< x L)) A))))