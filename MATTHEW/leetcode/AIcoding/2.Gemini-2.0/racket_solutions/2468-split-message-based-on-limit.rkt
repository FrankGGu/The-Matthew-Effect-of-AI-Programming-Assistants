(define (splitMessage message limit)
  (define (digits n)
    (if (= n 0)
        1
        (+ 1 (digits (quotient n 10)))))

  (define (count-parts prefix-len)
    (let loop ([i 1] [len 0])
      (if (> len (string-length message))
          -1
          (let* ([part-len (+ prefix-len (digits i) (digits (count-parts prefix-len)) 3)]
                 [new-len (+ len part-len)])
            (if (= (count-parts prefix-len) -1)
                -1
                (if (> new-len (string-length message))
                    i
                    (loop (+ 1 i) new-len))))))

  (define (solve)
    (let loop ([prefix-len 1])
      (let ([parts (count-parts prefix-len)])
        (if (= parts -1)
            (loop (+ 1 prefix-len))
            (let loop2 ([i 1] [start 0] [result '()])
              (if (> i parts)
                  (reverse result)
                  (let* ([prefix (string-append "<" (number->string i) "/" (number->string parts) ">")]
                         [len (string-length prefix)]
                         [part-len (- limit len)]
                         [end (min (+ start part-len) (string-length message))]
                         [msg-part (substring message start end)]
                         [full-msg (string-append msg-part prefix)])
                    (loop2 (+ 1 i) end (cons full-msg result)))))))))

  (cond
    [(> limit 5) (solve)]
    [else '()]))