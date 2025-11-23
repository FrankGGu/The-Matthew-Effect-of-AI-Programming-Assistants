(define (count-beautiful-substrings s)
  (define (is-beautiful substring)
    (let loop ((count 0) (last-char #\0) (chars (string->list substring)))
      (cond
        [(null? chars) (= count 2)]
        [(equal? (car chars) last-char) (loop count last-char (cdr chars))]
        [else (loop (+ count 1) (car chars) (cdr chars))])))
  (define (count-helper start end)
    (if (>= end (string-length s))
        0
        (+ (if (is-beautiful (substring s start end))
               1
               0)
           (count-helper start (+ end 1)))))
  (define (count-all start)
    (if (>= start (string-length s))
        0
        (+ (count-helper start (+ start 1)) (count-all (+ start 1)))))
  (count-all 0))