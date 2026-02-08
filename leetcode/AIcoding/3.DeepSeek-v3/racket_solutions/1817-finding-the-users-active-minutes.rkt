(define (finding-users-active-minutes logs k)
  (let* ([user-times (make-hash)]
         [result (make-vector k 0)])
    (for ([log logs])
      (let ([user (first log)]
            [time (second log)])
        (hash-update! user-times user
                      (lambda (times) (set-add times time))
                      (set))))
    (for ([(user times) (in-hash user-times)])
      (let ([count (set-count times)])
        (when (<= 1 count k)
          (vector-set! result (- count 1) (+ (vector-ref result (- count 1)) 1))))
    result))