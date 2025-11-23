(define (count-homogenous-substrings s)
  (let* ([n (string-length s)]
         [mod-val 1000000007])
    (if (= n 0)
        0
        (let loop ([i 1]
                   [total 0]
                   [current-char (string-ref s 0)]
                   [current-count 1])
          (if (= i n)
              (modulo (+ total (quotient (* current-count (+ current-count 1)) 2)) mod-val)
              (let ([char-at-i (string-ref s i)])
                (if (char=? char-at-i current-char)
                    (loop (+ i 1) total current-char (+ current-count 1))
                    (loop (+ i 1)
                          (modulo (+ total (quotient (* current-count (+ current-count 1)) 2)) mod-val)
                          char-at-i
                          1))))))))