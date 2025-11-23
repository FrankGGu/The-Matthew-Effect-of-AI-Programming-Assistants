(define (max-vowels s k)
  (define (vowel? c)
    (member c '(#\a #\e #\i #\o #\u)))

  (define (count-vowels str)
    (length (filter vowel? (string->list str))))

  (define (solve str k)
    (if (< (string-length str) k)
        0
        (let loop ([i 0] [max-count 0])
          (if (>= i (- (string-length str) k) 1)
              max-count
              (let ([substring (substring str i (+ i k))]
                    [count (count-vowels substring)])
                (loop (+ i 1) (max max-count count)))))))

  (solve s k))