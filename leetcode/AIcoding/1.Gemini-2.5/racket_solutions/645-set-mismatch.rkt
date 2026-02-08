(define (find-error-nums nums)
  (let* ([n (length nums)]
         [expected-sum (/ (* n (+ n 1)) 2)]
         [actual-sum 0]
         [seen (make-hash)]
         [duplicate 0])
    (for ([num nums])
      (set! actual-sum (+ actual-sum num))
      (when (hash-has-key? seen num)
        (set! duplicate num))
      (hash-set! seen num #t))
    (let ([missing (+ (- expected-sum actual-sum) duplicate)])
      (list duplicate missing))))