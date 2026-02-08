(define (min-time-to-type word)
  (let loop ([chars (string->list word)]
             [curr-pos 0]
             [time 0])
    (if (null? chars)
        time
        (let* ([next-char (char->integer (car chars))]
               [next-pos (- next-char (char->integer #\a))])
          (loop (cdr chars)
                next-pos
                (+ time (min (abs (- next-pos curr-pos))
                             (- 26 (abs (- next-pos curr-pos))))
                   1))))))