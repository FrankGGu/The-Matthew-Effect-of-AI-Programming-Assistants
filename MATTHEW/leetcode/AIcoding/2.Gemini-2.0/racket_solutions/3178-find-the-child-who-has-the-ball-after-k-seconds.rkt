(define (find-the-winner n k)
  (let loop ([people (range 1 (+ n 1))]
             [start 0])
    (if (= (length people) 1)
        (list-ref people 0)
        (let* ([remove-index (modulo (+ start (- 1) k) (length people))]
               [new-people (append (take people remove-index) (drop people (+ remove-index 1)))])
          (loop new-people remove-index)))))

(define (find-the-child-who-has-the-ball-after-k-seconds n k)
  (let loop ([current-position 0]
             [direction 1]
             [remaining-seconds k])
    (if (= remaining-seconds 0)
        current-position
        (let ([next-position (+ current-position direction)])
          (cond
            [(= next-position (- n 1))
             (loop next-position -1 (- remaining-seconds 1))]
            [(= next-position 0)
             (loop next-position 1 (- remaining-seconds 1))]
            [else
             (loop next-position direction (- remaining-seconds 1))])))))