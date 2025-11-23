(define (generate-next-term s)
  (let* ([len (string-length s)])
    (if (= len 0)
        ""
        (let loop ([i 0] [acc-parts '()]) ; acc-parts will be built in reverse
          (if (< i len)
              (let* ([current-char (stringref s i)]
                     [j (+ i 1)])
                (let inner-loop ([k j])
                  (if (and (< k len) (char=? (stringref s k) current-char))
                      (inner-loop (+ k 1))
                      ;; k is the index of the first different char or end of string
                      (let ([count (- k i)])
                        (loop k (cons (string current-char) (cons (number->string count) acc-parts)))))))
              ;; End of string, reverse and join
              (apply string-append (reverse acc-parts)))))))

(define (countAndSay n)
  (if (= n 1)
      "1"
      (let loop ([k 2] [current-s "1"])
        (if (= k n)
            (generate-next-term current-s)
            (loop (+ k 1) (generate-next-term current-s))))))