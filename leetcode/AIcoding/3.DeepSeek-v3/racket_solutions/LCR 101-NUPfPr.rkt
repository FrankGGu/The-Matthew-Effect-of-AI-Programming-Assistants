(define/contract (can-partition nums)
  (-> (listof exact-integer?) boolean?)
  (let* ([total (apply + nums)]
         [target (quotient total 2)])
    (if (odd? total)
        #f
        (let ([dp (make-hash '((0 . #t)))])
          (for ([num (in-list nums)])
            (for ([sum (in-list (hash-keys dp))]
                  #:when (<= (+ sum num) target)
                  #:unless (hash-has-key? dp (+ sum num)))
              (hash-set! dp (+ sum num) #t)))
          (hash-ref dp target #f)))))