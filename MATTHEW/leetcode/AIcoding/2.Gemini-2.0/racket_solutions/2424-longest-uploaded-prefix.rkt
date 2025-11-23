(define (longest-uploaded-prefix uploaded n)
  (let loop ([uploaded uploaded] [prefix 0] [seen (make-vector (+ n 1) #f)])
    (cond
      [(null? uploaded)
       (let loop2 ([i 1])
         (cond
           [(>= i n) n]
           [(vector-ref seen i) (loop2 (+ i 1))]
           [else (- i 1)]))]
      [else
       (vector-set! seen (car uploaded) #t)
       (let loop2 ([i 1])
         (cond
           [(>= i n) n]
           [(vector-ref seen i) (loop2 (+ i 1))]
           [else (- i 1)]))])))