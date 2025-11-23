(define (find-kth-bit n k)
  (define (helper n)
    (if (= n 1)
        "0"
        (let ([prev (helper (- n 1))])
          (string-append prev "1" (invert-and-reverse prev)))))
  (define (invert-and-reverse s)
    (list->string 
     (reverse 
      (map (lambda (c) (if (char=? c #\0) #\1 #\0)) 
           (string->list s)))))
  (string-ref (helper n) (- k 1))))