(define (max-total-reward operations)
  (define (helper ops current-reward)
    (cond [(empty? ops) current-reward]
          [else
           (let* ([op (first ops)]
                  [type (first op)]
                  [index (second op)]
                  [value (third op)]
                  [next-ops (rest ops)])
             (cond
               [(= type 0) (helper next-ops (+ current-reward value))]
               [(= type 1)
                (let ([new-value (max 0 (- value 1))])
                  (if (= new-value 0)
                      (helper next-ops current-reward)
                      (helper (cons (list type index new-value) next-ops) current-reward)))]
               [else (error "Invalid operation type")])))]))
  (helper operations 0))