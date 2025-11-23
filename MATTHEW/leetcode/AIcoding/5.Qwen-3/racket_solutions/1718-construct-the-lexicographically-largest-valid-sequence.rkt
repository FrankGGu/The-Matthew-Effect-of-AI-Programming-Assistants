#lang racket

(define (construct-lexicographical-largest-valid-sequence n)
  (define result '())
  (define used (make-vector (* n 2) #f))
  (define (backtrack pos)
    (cond
      [(= pos n) (set! result (reverse (take (reverse (map cadr result)) n))) #t]
      [else
       (for ([i (in-range (* 2 n) 0 -1)])
         (when (and (not (vector-ref used i))
                    (or (= i 1)
                        (and (>= i 2)
                             (not (vector-ref used (- i 1)))
                             (or (= i 2)
                                 (and (>= i 3)
                                      (not (vector-ref used (- i 2))))))))
           (vector-set! used i #t)
           (set! result (cons (cons i (length result)) result))
           (when (backtrack (+ pos 1)) (return #t))
           (vector-set! used i #f)
           (set! result (cdr result)))]
       #f))
  (backtrack 0)
  (map car result))