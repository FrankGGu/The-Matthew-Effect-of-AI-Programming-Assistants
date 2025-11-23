(define (create-target-array nums index)
  (let loop ([nums nums]
             [index index]
             [target '()])
    (if (null? nums)
        (reverse target)
        (let ([num (car nums)]
              [idx (car index)])
          (loop (cdr nums)
                (cdr index)
                (reverse (cons num (reverse (list-tail (reverse target) (- (length target) idx)))))))))