(define (sum-digits n)
  (if (= n 0)
      0
      (+ (modulo n 10) (sum-digits (quotient n 10)))))

(define (max-sum-of-pair-with-equal-sum-of-digits nums)
  (let ((sums (make-hash)))
    (for ([num nums])
      (let ((digit-sum (sum-digits num)))
        (if (hash-has-key? sums digit-sum)
            (hash-set! sums digit-sum (cons num (hash-ref sums digit-sum)))
            (hash-set! sums digit-sum (list num)))))
    (let ((max-sum -1))
      (hash-for-each sums
                     (lambda (k v)
                       (if (> (length v) 1)
                           (let ((sorted-v (sort v >)))
                             (set! max-sum (max max-sum (+ (car sorted-v) (cadr sorted-v))))))))
      max-sum)))