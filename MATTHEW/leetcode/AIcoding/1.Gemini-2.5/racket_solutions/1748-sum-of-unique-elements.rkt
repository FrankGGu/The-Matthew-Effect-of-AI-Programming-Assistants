(define (sum-of-unique-elements nums)
  (define counts (make-hash))

  (for-each (lambda (num)
              (hash-update! counts num add1 0))
            nums)

  (define total-sum 0)
  (hash-for-each (lambda (num count)
                   (when (= count 1)
                     (set! total-sum (+ total-sum num))))
                 counts)
  total-sum)