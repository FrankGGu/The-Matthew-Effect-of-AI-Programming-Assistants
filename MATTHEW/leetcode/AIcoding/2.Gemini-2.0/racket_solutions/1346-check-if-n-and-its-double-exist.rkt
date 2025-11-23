(define (check-if-exist arr)
  (let loop ([lst arr] [seen (hash)])
    (cond
      [(null? lst) #f]
      [(hash-has-key? seen (/ (car lst) 2.0)) (and (not (equal? (car lst) 0)) (equal? (* 2.0 (hash-ref seen (/ (car lst) 2.0))) (car lst)))]
      [(hash-has-key? seen (* 2 (car lst)))) #t]
      [(and (equal? (car lst) 0) (hash-has-key? seen 0)) #t]
      [else (begin (hash-set! seen (car lst) (car lst))
                   (loop (cdr lst) seen))])))