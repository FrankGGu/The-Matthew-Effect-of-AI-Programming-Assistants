(define (words-typing sentence rows cols)
  (let* ([s (string-join sentence " ")]
         [len (string-length s)]
         [n (length sentence)]
         [total 0]
         [pos 0])
    (for ([i (in-range rows)])
      (let ([remaining (+ cols 1)])
        (let loop ()
          (let ([word-len (string-length (list-ref sentence (modulo pos n)))])
            (if (> word-len remaining)
                (set! remaining cols)
                (begin
                  (set! remaining (- remaining word-len 1))
                  (set! pos (add1 pos))
                  (when (= (modulo pos n) 0)
                    (set! total (add1 total)))
                  (loop)))))))
    total))