(define (max-diff a)
  (define s (number->string a))
  (define (find-first-digit-not-9 str)
    (let loop ([i 0])
      (cond
        [(>= i (string-length str)) #f]
        [(char=? (string-ref str i) #\9) (loop (+ i 1))]
        [else i])))
  (define (find-first-digit str)
    (let loop ([i 0])
      (if (>= i (string-length str)) #f
          i)))

  (define (max-num str)
    (let ([first-non-9-index (find-first-digit-not-9 str)])
      (if (not first-non-9-index)
          (string->number str)
          (let ([digit-to-replace (string-ref str first-non-9-index)])
            (string->number (string-map (lambda (c) (if (char=? c digit-to-replace) #\9 c)) str))))))

  (define (min-num str)
    (let ([first-digit-index (find-first-digit str)])
      (if (not first-digit-index)
          (string->number str)
          (let ([digit-to-replace (string-ref str first-digit-index)])
            (let ([replacement-digit (if (= first-digit-index 0) #\0 #\0)])
              (string->number (string-map (lambda (c) (if (char=? c digit-to-replace) replacement-digit c)) str)))))))

  (- (max-num s) (min-num s)))