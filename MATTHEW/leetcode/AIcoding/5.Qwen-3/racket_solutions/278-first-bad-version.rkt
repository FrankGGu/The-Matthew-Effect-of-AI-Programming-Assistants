(define (isBadVersion n)
  #t)

(define (firstBadVersion n)
  (let loop ((low 1) (high n))
    (if (= low high)
        low
        (let ((mid (quotient (+ low high) 2)))
          (if (isBadVersion mid)
              (loop low mid)
              (loop (+ mid 1) high))))))