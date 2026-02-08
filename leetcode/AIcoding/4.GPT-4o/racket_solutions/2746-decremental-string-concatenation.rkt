(define (decremental-string-concatenation s)
  (let loop ((n (string-length s)) (result ""))
    (if (= n 0)
        result
        (loop (sub1 n) (string-append result (substring s 0 n))))))

(decremental-string-concatenation "abcdef")