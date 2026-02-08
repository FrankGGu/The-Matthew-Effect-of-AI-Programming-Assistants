(define (divideArray nums d)
  (define (can-divide mid)
    (define (count-groups)
      (define (helper nums limit count)
        (cond
          ((null? nums) count)
          ((<= (car nums) limit) (helper (cdr nums) limit count))
          (else (helper (cdr nums) (+ (car nums) d) (+ count 1)))))
      (helper nums (car nums) 1))
    (<= (count-groups) mid))

  (define (binary-search lo hi)
    (if (>= lo hi)
        lo
        (let* ((mid (quotient (+ lo hi) 2))
               (can (can-divide mid)))
          (if can
              (binary-search lo mid)
              (binary-search (+ mid 1) hi)))))

  (binary-search 1 (length nums)))