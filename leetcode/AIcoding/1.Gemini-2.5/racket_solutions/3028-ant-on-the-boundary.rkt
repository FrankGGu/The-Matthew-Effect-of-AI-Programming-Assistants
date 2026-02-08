(define (return-to-boundary nums)
  (let ([current-position 0]
        [count-at-zero 0])
    (for-each (lambda (step)
                (set! current-position (+ current-position step))
                (when (= current-position 0)
                  (set! count-at-zero (+ count-at-zero 1))))
              nums)
    count-at-zero))