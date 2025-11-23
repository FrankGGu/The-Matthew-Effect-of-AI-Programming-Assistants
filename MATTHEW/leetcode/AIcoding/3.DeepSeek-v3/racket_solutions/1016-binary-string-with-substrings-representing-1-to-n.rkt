(define (query-string s n)
  (let loop ((i 1))
    (cond
      ((> i n) #t)
      ((not (string-contains? s (number->string i 2))) #f)
      (else (loop (+ i 1))))))