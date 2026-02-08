(define (longest-alphabetical-continuous-substring s)
  (let* ([len (string-length s)])
    (cond
      [(= len 0) 0]
      [else
       (let loop ([i 1]
                  [max-len 1]
                  [current-len 1])
         (if (>= i len)
             max-len
             (let* ([current-char (string-ref s i)]
                    [prev-char (string-ref s (- i 1))]
                    [new-current-len (if (= (char->integer current-char) (add1 (char->integer prev-char)))
                                         (add1 current-len)
                                         1)])
               (loop (add1 i)
                     (max max-len new-current-len)
                     new-current-len))))])))