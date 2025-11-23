(define (count-and-say n)
  (define (next-number s)
    (define (helper s acc count prev)
      (cond
        [(empty? s)
         (string-append acc (number->string count) (string prev))]
        [(equal? (first s) prev)
         (helper (rest s) acc (+ count 1) prev)]
        [else
         (helper (rest s) (string-append acc (number->string count) (string prev)) 1 (first s))]))
    (helper (string->list s) "" 0 (first (string->list s))))

  (define (generate-sequence n current)
    (if (= n 1)
        current
        (generate-sequence (- n 1) (next-number current))))

  (generate-sequence n "1"))