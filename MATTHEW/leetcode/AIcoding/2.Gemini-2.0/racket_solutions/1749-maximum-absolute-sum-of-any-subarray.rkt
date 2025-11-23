(define (max-absolute-sum nums)
  (let loop ([nums nums] [max-so-far 0] [min-so-far 0] [max-abs-sum 0])
    (if (null? nums)
        max-abs-sum
        (let ([num (car nums)])
          (let ([new-max-so-far (max 0 (+ max-so-far num))]
                [new-min-so-far (min 0 (+ min-so-far num))])
            (loop (cdr nums)
                  new-max-so-far
                  new-min-so-far
                  (max max-abs-sum (max new-max-so-far (- new-min-so-far)))))))))