(define (special-array nums)
  (define n (length nums))

  (let loop ([x 0])
    (cond
      [(= x (add1 n))
       -1]
      [else
       (define count-greater-or-equal-x
         (count (lambda (num) (>= num x)) nums))
       (if (= count-greater-or-equal-x x)
           x
           (loop (add1 x)))])))