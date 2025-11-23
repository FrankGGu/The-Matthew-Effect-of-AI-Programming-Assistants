(define/contract (optimal-division nums)
  (-> (listof exact-integer?) string?)
  (cond
    [(null? nums) ""]
    [(null? (cdr nums)) (number->string (car nums))]
    [(null? (cddr nums)) (string-append (number->string (car nums)) "/" (number->string (cadr nums)))]
    [else
     (string-append
      (number->string (car nums))
      "/("
      (let loop ([rest (cdr nums)])
        (if (null? (cdr rest))
            (number->string (car rest))
            (string-append (number->string (car rest)) "/" (loop (cdr rest)))))
      ")")]))