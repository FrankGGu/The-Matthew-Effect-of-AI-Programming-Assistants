(define (reverse-degree s)
  (let ([n (string-length s)])
    (if (zero? n)
        ""
        (let loop ([i 0] [acc ""])
          (if (= i n)
              acc
              (loop (+ i 1) (string-append (substring s i (+ i 1)) acc)))))))