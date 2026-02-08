(define/contract (largest-number nums)
  (-> (listof exact-integer?) string?)
  (define (compare a b)
    (let ([s1 (string-append (number->string a) (number->string b))]
          [s2 (string-append (number->string b) (number->string a))])
      (string<? s2 s1)))
  (let* ([sorted-nums (sort nums compare)]
         [result (apply string-append (map number->string sorted-nums))])
    (if (string=? (substring result 0 1) "0")
        "0"
        result)))