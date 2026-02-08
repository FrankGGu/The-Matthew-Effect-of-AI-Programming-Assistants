(define (are-numbers-ascending s)
  (define (string->list s)
    (string->split s " "))

  (define (string->int s)
    (string->number s))

  (define (is-number? s)
    (and (string? s)
         (regexp-match? #rx"^[0-9]+$" s)))

  (define words (string->list s))

  (define numbers
    (filter is-number? words))

  (define nums (map string->int numbers))

  (define (ascending? lst prev)
    (cond
      [(null? lst) #t]
      [(> (car lst) prev) (ascending? (cdr lst) (car lst))]
      [else #f]))

  (if (null? nums)
      #t
      (ascending? (cdr nums) (car nums))))