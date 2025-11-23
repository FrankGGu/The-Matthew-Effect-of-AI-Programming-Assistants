(define (countAndSay n)
  (if (= n 1)
      "1"
      (let loop ((s (countAndSay (- n 1))) (result "") (count 1) (current #\0))
        (cond
          ((string-empty? s) result)
          ((char=? current (string-ref s 0))
           (loop (substring s 1) result count current))
          (else
           (loop (substring s 1) (string-append result (number->string count) (string (string-ref s 0))) 1 (string-ref s 0)))))))

(countAndSay n)