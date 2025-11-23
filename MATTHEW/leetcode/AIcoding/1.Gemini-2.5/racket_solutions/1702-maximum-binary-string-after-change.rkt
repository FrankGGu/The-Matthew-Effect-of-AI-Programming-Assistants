(define (maximum-binary-string binary)
  (let* ((n (string-length binary))
         (zeros-count (let loop ((idx 0) (count 0))
                        (if (= idx n)
                            count
                            (loop (add1 idx)
                                  (if (char=? (string-ref binary idx) #\0)
                                      (add1 count)
                                      count))))))
    (if (= zeros-count 0)
        binary
        (string-append (make-string (- n 1) #\1) "0"))))