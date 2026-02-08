(define (max-value-after-insertion n x)
  (define n-str (number->string n))
  (define len (string-length n-str))
  (define neg? (char=? (string-ref n-str 0) #\-))

  (cond
    [neg?
     (let loop ([i 1])
       (cond
         [(= i len) (string-append n-str (string x))]
         [(char<=? (string-ref n-str i) (string-ref (string x) 0))
          (string-append (substring n-str 0 i) (string x) (substring n-str i len))]
         [else (loop (+ i 1))]))]
    [else
     (let loop ([i 0])
       (cond
         [(= i len) (string-append n-str (string x))]
         [(char>=? (string-ref n-str i) (string-ref (string x) 0))
          (string-append (substring n-str 0 i) (string x) (substring n-str i len))]
         [else (loop (+ i 1))]))]))