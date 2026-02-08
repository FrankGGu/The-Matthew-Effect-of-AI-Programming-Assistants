(define (find-key nums)
  (let loop ([nums nums] [key 0])
    (cond
      [(empty? nums) key]
      [(member? key nums) (loop nums (+ key 1))]
      [else key])))