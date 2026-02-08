(define (num-different-integers word)
  (define (char-digit? c)
    (char-numeric? c))
  (let loop ([i 0] [current #f] [seen (set)])
    (cond
      [(>= i (string-length word))
       (if current
           (set-count (set-add seen current))
           (set-count seen))]
      [(char-digit? (string-ref word i))
       (let ([digit (string-ref word i)])
         (loop (add1 i)
               (if current
                   (string-append current (string digit))
                   (string digit))
               seen))]
      [current
       (loop (add1 i) #f (set-add seen current))]
      [else
       (loop (add1 i) #f seen)])))