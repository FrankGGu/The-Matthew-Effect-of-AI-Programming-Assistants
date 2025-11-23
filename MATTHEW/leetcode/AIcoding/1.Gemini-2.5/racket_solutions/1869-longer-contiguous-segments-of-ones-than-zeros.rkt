(define (check-segments s)
  (let* ([n (string-length s)])
    (if (= n 0)
        #f ; Problem constraints usually guarantee non-empty string, but handle defensively.
        (let-values ([(ones-segments zeros-segments current-char-final)]
                     (for/fold ([ones-segments 0]
                                [zeros-segments 0]
                                [current-char (string-ref s 0)])
                               ([i (in-range 1 n)])
                       (let ([char-at-i (string-ref s i)])
                         (if (char=? char-at-i current-char)
                             (values ones-segments zeros-segments current-char)
                             (if (char=? current-char #\1)
                                 (values (+ ones-segments 1) zeros-segments char-at-i)
                                 (values ones-segments (+ zeros-segments 1) char-at-i)))))
          (let ([final-ones (if (char=? current-char-final #\1)
                                (+ ones-segments 1)
                                ones-segments)]
                [final-zeros (if (char=? current-char-final #\0)
                                 (+ zeros-segments 1)
                                 zeros-segments)])
            (> final-ones final-zeros))))))