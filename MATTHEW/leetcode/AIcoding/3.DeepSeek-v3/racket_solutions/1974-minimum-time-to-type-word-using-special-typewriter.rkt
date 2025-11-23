(define/contract (min-time-to-type word)
  (-> string? exact-integer?)
  (let loop ([prev #\a] [time 0] [chars (string->list word)])
    (if (null? chars)
        time
        (let* ([curr (car chars)]
               [diff (abs (- (char->integer curr) (char->integer prev)))]
               [move (min diff (- 26 diff))])
          (loop curr (+ time move 1) (cdr chars))))))