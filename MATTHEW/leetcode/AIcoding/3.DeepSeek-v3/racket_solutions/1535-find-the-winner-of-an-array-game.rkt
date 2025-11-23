(define (get-winner arr k)
  (let loop ([current (car arr)]
             [count 0]
             [rest (cdr arr)])
    (cond
      [(>= count k) current]
      [(null? rest) current]
      [(> current (car rest)) (loop current (add1 count) (cdr rest))]
      [else (loop (car rest) 1 (cons current (cdr rest)))])))