(define (minimum-card-pickup cards)
  (let loop ([seen '()]
             [min-len #inf]
             [i 0])
    (cond
      [(>= i (length cards)) (if (equal? min-len #inf) -1 min-len)]
      [(ormap (lambda (p) (equal? (car p) (list-ref cards i))) seen)
       (let* ([prev-index (cadr (findf (lambda (p) (equal? (car p) (list-ref cards i))) seen))]
              [curr-len (+ (- i prev-index) 1)])
         (loop (append (remove (findf (lambda (p) (equal? (car p) (list-ref cards i))) seen) seen) (list (cons (list-ref cards i) i)))
               (min min-len curr-len)
               (+ i 1)))]
      [else (loop (append seen (list (cons (list-ref cards i) i))) min-len (+ i 1))])))