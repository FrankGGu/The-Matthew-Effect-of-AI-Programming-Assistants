(define (find-special-integer arr)
  (let* ((n (length arr))
         (threshold (/ n 4)))
    (for/first ([i (in-range 0 (- n (inexact->exact (floor threshold)))))
                #:when (>= (- (index-of arr (+ i (inexact->exact (floor threshold)))) i 1) threshold)
                (list-ref arr i))))

(define (index-of arr x)
  (let loop ([i 0])
    (cond
      [(>= i (length arr)) (length arr)]
      [(equal? (list-ref arr i) x) i]
      [else (loop (+ i 1))])))