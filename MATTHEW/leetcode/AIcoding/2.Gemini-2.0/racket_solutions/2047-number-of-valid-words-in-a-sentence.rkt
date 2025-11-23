(define (count-valid-words sentence)
  (define (valid-word? word)
    (and
     (not (string=? "" word))
     (let loop ([i 0] [hyphen-count 0])
       (cond
         [(>= i (string-length word))
          (and (<= hyphen-count 1)
               (or (not (string-contains? word (regexp "[0-9]")))
                   #f)
               (or (not (string-contains? word (regexp "[!.,]$")))
                   (and (= i (add1 (string-length word)))
                        (not (string=? "" word))))
               (or (not (string-contains? word (regexp "[!.,]")))
                   #f))]
         [(char=? (string-ref word i) #\-)
          (if (and (> i 0) (< i (sub1 (string-length word)))
                   (char-alphabetic? (string-ref word (sub1 i)))
                   (char-alphabetic? (string-ref word (add1 i))))
              (loop (add1 i) (add1 hyphen-count))
              #f)]
         [(char-alphabetic? (string-ref word i))
          (loop (add1 i) hyphen-count)]
         [(char=? (string-ref word i) #\!)
          (if (= i (sub1 (string-length word)))
              (loop (add1 i) hyphen-count)
              #f)]
          [(char=? (string-ref word i) #\.)
          (if (= i (sub1 (string-length word)))
              (loop (add1 i) hyphen-count)
              #f)]
          [(char=? (string-ref word i) #\,)
          (if (= i (sub1 (string-length word)))
              (loop (add1 i) hyphen-count)
              #f)]
         [else #f])))))

  (length (filter valid-word? (string-split sentence))))