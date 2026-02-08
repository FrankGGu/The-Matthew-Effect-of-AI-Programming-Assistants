(define (create-target-array nums index)
  (for/fold ([target '()])
            ([num (in-list nums)]
             [idx (in-list index)])
    (let ([prefix (take target idx)]
          [suffix (drop target idx)])
      (append prefix (list num) suffix))))