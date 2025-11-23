(define (digit-count-equal? nums)
  (let loop ([i 0])
    (if (= i (string-length nums))
        #t
        (let ([digit-count (string->number (substring nums i (+ i 1)))]
              [actual-count (count (lambda (c) (char=? c (string-ref nums i))) (string->list nums))])
          (if (= digit-count actual-count)
              (loop (+ i 1))
              #f)))))