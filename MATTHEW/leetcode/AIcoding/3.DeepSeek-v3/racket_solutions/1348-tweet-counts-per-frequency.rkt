(define tweet-counts%
  (class object%
    (super-new)
    (init-field)
    (define h (make-hash))

    (define/public (record-tweet tweet-name time)
      (hash-update! h tweet-name (lambda (v) (cons time v)) '()))

    (define/public (get-tweet-counts-per-frequency freq tweet-name start-time end-time)
      (define delta
        (cond
          [(string=? freq "minute") 60]
          [(string=? freq "hour") 3600]
          [(string=? freq "day") 86400]))
      (define times (sort (hash-ref h tweet-name '()) <))
      (define result '())
      (define current-start start-time)
      (while (<= current-start end-time)
        (define current-end (min (+ current-start delta -1) end-time))
        (define count
          (let loop ([l times] [cnt 0])
            (if (null? l)
                cnt
                (let ([t (car l)])
                  (if (> t current-end)
                      cnt
                      (loop (cdr l) (if (>= t current-start) (add1 cnt) cnt))))))
        (set! result (cons count result))
        (set! current-start (+ current-start delta)))
      (reverse result))))