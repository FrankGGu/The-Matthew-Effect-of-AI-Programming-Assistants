(define (patching-array nums n)
  (let loop ([nums nums] [i 0] [patches 0] [miss 1])
    (cond
      [(>= miss n) patches]
      [(and (not (null? nums)) (<= (car nums) miss))
       (loop (cdr nums) (+ i 1) patches (+ miss (car nums)))]
      [else
       (loop nums (+ i 1) (+ patches 1) (+ miss miss))])))