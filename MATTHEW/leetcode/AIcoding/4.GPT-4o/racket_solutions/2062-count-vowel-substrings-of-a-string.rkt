(define (count-vowel-substrings s)
  (define vowels (set '(#\a #\e #\i #\o #\u)))
  (define (is-vowel? c) (set-member? vowels c))
  (define (count substr)
    (if (or (null? substr) (not (is-vowel? (car substr))))
        0
        (+ 1 (count (cdr substr)))))
  (define (helper start end)
    (if (>= end (string-length s))
        0
        (let loop ([start start] [end end] [count 0])
          (cond
            [(= end (string-length s)) count]
            [(is-vowel? (string-ref s end))
             (if (and (is-vowel? (string-ref s start))
                      (not (and (zero? start) (= end start))))
                 (loop start (+ end 1) (+ count (count (substring s start (+ end 1)))))
                 (loop (+ start 1) end count))]
            [else (loop (+ start 1) (+ end 1) count)]))))
  (helper 0 0))