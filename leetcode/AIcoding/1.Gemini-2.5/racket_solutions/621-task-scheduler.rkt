(define (least-interval tasks n)
  (let* ([freqs (make-vector 26 0)]
         [total-tasks (length tasks)])

    (for-each (lambda (task-char)
                (let* ([idx (- (char->integer task-char) (char->integer #\A))]
                       [current-freq (vector-ref freqs idx)])
                  (vector-set! freqs idx (+ current-freq 1))))
              tasks)

    (let ([max-freq 0])
      (for-each (lambda (freq)
                  (when (> freq max-freq)
                    (set! max-freq freq)))
                (vector->list freqs))

      (let ([num-max-freq-tasks 0])
        (for-each (lambda (freq)
                    (when (= freq max-freq)
                      (set! num-max-freq-tasks (+ num-max-freq-tasks 1))))
                  (vector->list freqs))

        (let ([min-time-from-formula (+ (* (- max-freq 1) (+ n 1)) num-max-freq-tasks)])
          (max min-time-from-formula total-tasks))))))