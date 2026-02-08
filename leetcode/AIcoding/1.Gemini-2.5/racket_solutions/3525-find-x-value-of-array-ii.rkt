(define (special-array nums)
  (define n (length nums))

  (define (count-ge-x x)
    (for/sum ([num (in-list nums)])
      (if (>= num x) 1 0)))

  (for/first ([x (in-range 0 (add1 n))]
              #:when (= (count-ge-x x) x))
    x
    #:else -1))