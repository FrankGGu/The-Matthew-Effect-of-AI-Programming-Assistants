(define (max-factor-score nums)
  (define (factor-score n)
    (cond
      [(<= n 1) 0]
      [else
       (let loop ([i 2] [n n] [score 0])
         (cond
           [(> i (sqrt n))]
           (else
            (if (= (remainder n i) 0)
                (loop i (/ n i) (+ score i))
                (loop (+ i 1) n score)))))]))

  (apply max (map factor-score nums)))