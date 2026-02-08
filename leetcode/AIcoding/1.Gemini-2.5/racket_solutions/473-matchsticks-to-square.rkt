(define (makesquare matchsticks)
  (define n (length matchsticks))
  (define total-sum (apply + matchsticks))

  (when (not (zero? (remainder total-sum 4)))
    #f)

  (define side-length (/ total-sum 4))

  (define sorted-matchsticks (sort matchsticks >))

  (when (ormap (lambda (m) (> m side-length)) sorted-matchsticks)
    #f)

  (define sides (vector 0 0 0 0))

  (define (backtrack idx)
    (if (= idx n)
        (and (= (vector-ref sides 0) side-length)
             (= (vector-ref sides 1) side-length)
             (= (vector-ref sides 2) side-length)
             (= (vector-ref sides 3) side-length))
        (let ((current-matchstick (list-ref sorted-matchsticks idx)))
          (let loop ((i 0))
            (if (< i 4)
                (let ((current-side-length (vector-ref sides i)))
                  (if (<= (+ current-side-length current-matchstick) side-length)
                      (begin
                        (vector-set! sides i (+ current-side-length current-matchstick))
                        (if (backtrack (+ idx 1))
                            #t
                            (begin
                              (vector-set! sides i current-side-length)
                              (loop (+ i 1)))))
                      (loop (+ i 1))))
                #f)))))

  (backtrack 0))