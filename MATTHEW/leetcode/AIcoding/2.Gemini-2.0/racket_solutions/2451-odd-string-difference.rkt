(define (odd-string-difference words)
  (define (diff word)
    (map - (map char->integer (string->list word (add1 0))) (map char->integer (string->list word))))
  (define diffs (map diff words))
  (define (find-odd-one lst)
    (let ([first (car lst)]
          [second (cadr lst)]
          [third (caddr lst)])
      (cond
        [(= (count equal? (list first second third) first) 1)
         (cond [(equal? first second) 2] [(equal? first third) 1] [else 0])]
        [else -1])))
  (let ([index (find-odd-one diffs)])
    (if (= index -1)
        (if (not (equal? (car diffs) (cadr diffs)))
            (if (equal? (car diffs) (caddr diffs)) 1 0)
            2)
        (list-ref words index))))