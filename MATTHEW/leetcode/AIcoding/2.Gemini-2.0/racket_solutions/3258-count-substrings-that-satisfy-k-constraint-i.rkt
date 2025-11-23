(define (count-substrings s k)
  (let ([n (string-length s)])
    (let loop ([i 0] [count 0])
      (if (= i n)
          count
          (let loop2 ([j i] [max-char 0])
            (if (= j n)
                count
                (let ([char-code (char->integer (string-ref s j))])
                  (let ([new-max-char (max max-char char-code)])
                    (if (<= (- new-max-char (char->integer #\a)) k)
                        (loop2 (+ j 1) new-max-char)
                        (loop (+ i 1) (+ count (- j i))))))))))))