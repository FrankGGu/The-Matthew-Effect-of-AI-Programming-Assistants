(define (countAndSay n)
  (define (next s)
    (if (string=? s "")
        ""
        (let loop ((count 1) (char (string-ref s 0)) (rest (substring s 1)) (result ""))
          (cond
            ((string=? rest "")
             (string-append result (number->string count) (string char)))
            ((char=? (string-ref rest 0) char)
             (loop (+ count 1) char (substring rest 1) result))
            (else
             (loop 1 (string-ref rest 0) (substring rest 1) 
                   (string-append result (number->string count) (string char))))))))
  (define (helper n)
    (if (= n 1)
        "1"
        (next (helper (- n 1)))))
  (helper n))