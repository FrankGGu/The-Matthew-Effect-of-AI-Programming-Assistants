(define (findMaxConsecutiveOnes nums)
  (define (helper lst count max-count)
    (cond
      ((null? lst) max-count)
      ((= (car lst) 1) (helper (cdr lst) (+ count 1) (max (+ count 1) max-count)))
      (else (helper (cdr lst) 0 max-count))))
  (helper nums 0 0))