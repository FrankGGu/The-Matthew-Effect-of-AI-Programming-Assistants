(define (num-substrings-with-all-1s s)
  (define (count-ones s)
    (let loop ((s s) (count 0) (total 0))
      (cond
        ((null? s) total)
        ((equal? (car s) #\1) (loop (cdr s) (+ count 1) (+ total (+ count 1)))
        (else (loop (cdr s) 0 total)))))
  (count-ones (string->list s)))

(num-substrings-with-all-1s "0110111")