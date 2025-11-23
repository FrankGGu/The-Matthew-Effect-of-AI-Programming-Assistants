(define (parse-bool-expr expression)
  (define (eval expr)
    (cond
      [(char=? (string-ref expr 0) #\t)
       (let loop ([i 2] [acc #t])
         (cond
           [(>= i (string-length expr)) acc]
           [(char=? (string-ref expr i) #\f) (loop (+ i 2) (and acc #f))]
           [(char=? (string-ref expr i) #\t) (loop (+ i 2) (and acc #t))]
           [else acc]))]
      [(char=? (string-ref expr 0) #\f)
       #f]
      [(char=? (string-ref expr 0) #\t)
       #t]
      [(char=? (string-ref expr 0) #\!)
       (not (eval (substring expr 2 (- (string-length expr) 1))))]
      [(char=? (string-ref expr 0) #\&)
       (let loop ([i 2] [acc #t])
         (cond
           [(>= i (string-length expr)) acc]
           [(char=? (string-ref expr i) #\f) (loop (+ i 2) (and acc #f))]
           [(char=? (string-ref expr i) #\t) (loop (+ i 2) (and acc #t))]
           [else acc]))]
      [(char=? (string-ref expr 0) #\|)
       (let loop ([i 2] [acc #f])
         (cond
           [(>= i (string-length expr)) acc]
           [(char=? (string-ref expr i) #\f) (loop (+ i 2) (or acc #f))]
           [(char=? (string-ref expr i) #\t) (loop (+ i 2) (or acc #t))]
           [else acc]))]
      [else #f]))
  (eval expression))