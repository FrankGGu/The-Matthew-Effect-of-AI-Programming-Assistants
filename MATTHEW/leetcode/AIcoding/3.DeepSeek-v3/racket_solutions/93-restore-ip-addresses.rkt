(define (restore-ip-addresses s)
  (define (valid-segment seg)
    (and (<= (string-length seg) 3)
         (if (> (string-length seg) 1)
             (not (char=? (string-ref seg 0) #\0))
             #t)
         (<= (string->number seg) 255)))

  (define (backtrack s start parts result)
    (cond
      [(and (= (length parts) 4) (= start (string-length s)))
       (cons (string-join parts ".") result)]
      [(or (> (length parts) 4) (>= start (string-length s)))
       result]
      [else
       (let loop ([end (add1 start)] [res result])
         (if (and (<= end (string-length s))
                  (valid-segment (substring s start end)))
             (loop (add1 end)
                   (backtrack s end (cons (substring s start end) parts) res))
             res)))]))

  (backtrack s 0 '() '()))