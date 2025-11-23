(define/contract (mask-pii s)
  (-> string? string?)
  (if (string-contains? s "@")
      (mask-email s)
      (mask-phone s)))

(define (mask-email s)
  (let* ([lower-s (string-downcase s)]
         [parts (string-split lower-s "@")]
         [name (car parts)]
         [domain (cadr parts)]
         [masked-name (string-append (substring name 0 1) "*****" (substring name (- (string-length name) 1)))])
    (string-append masked-name "@" domain)))

(define (mask-phone s)
  (let* ([digits (filter char-numeric? (string->list s))]
         [n (length digits)]
         [last-four (list->string (take-right digits 4))]
         [local (case n
                  [(10) ""]
                  [(11) "+*-"]
                  [(12) "+**-"]
                  [(13) "+***-"]
                  [else ""])])
    (string-append local "***-***-" last-four)))