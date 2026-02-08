(define (maximum-gap nums)
  (if (< (length nums) 2)
      0
      (let* ([sorted-nums (sort nums <)])
        (let find-max-diff ([lst (cdr sorted-nums)] [prev (car sorted-nums)] [max-so-far 0])
          (if (null? lst)
              max-so-far
              (let* ([current (car lst)]
                     [diff (- current prev)])
                (find-max-diff (cdr lst) current (max max-so-far diff))))))))