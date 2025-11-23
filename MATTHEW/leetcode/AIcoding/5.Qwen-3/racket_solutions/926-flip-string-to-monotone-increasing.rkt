(define (min-flips-monotone s)
  (define (helper s count flip)
    (cond [(null? s) count]
          [(= (car s) 1) (helper (cdr s) count flip)]
          [else (helper (cdr s) (+ count 1) #t)]))
  (let loop ([s s] [count 0] [flip #f])
    (cond [(null? s) count]
          [(and flip (= (car s) 0)) (loop (cdr s) (+ count 1) #t)]
          [(= (car s) 1) (loop (cdr s) count #t)]
          [else (loop (cdr s) count #f)])))