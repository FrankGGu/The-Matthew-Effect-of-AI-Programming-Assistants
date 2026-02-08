(define (maximum-number num-str change)
  (define (char->digit c) (- (char->integer c) (char->integer #\0)))
  (define (digit->char d) (integer->char (+ d (char->integer #\0))))

  (define num-list (string->list num-str))
  (define changed? #f)
  (define result '())

  (for ([c (in-list num-list)])
    (define d (char->digit c))
    (define new-d (vector-ref change d))
    (cond
      [(and (not changed?) (> new-d d))
       (set! changed? #t)
       (set! result (cons (digit->char new-d) result))]
      [(and changed? (>= new-d (char->digit (car result))))
       (set! result (cons (digit->char new-d) result))]
      [else
       (set! result (cons c result))]))

  (define final-str (list->string (reverse result)))
  (string->number final-str))