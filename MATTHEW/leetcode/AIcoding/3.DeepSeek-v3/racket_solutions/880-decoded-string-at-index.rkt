(define (decode-at-index s k)
  (let loop ([i 0] [size 0] [s (string->list s)])
    (cond
      [(>= size k) 
       (let backtrack ([s (reverse s)] [size size] [k k])
         (let* ([c (car s)]
                [new-size (if (char-numeric? c)
                              (quotient size (- (char->integer c) 48))
                              size)]
                [new-k (if (char-numeric? c)
                           (remainder k new-size)
                           k)])
           (cond
             [(and (not (char-numeric? c)) (= (remainder k new-size) 0)) (string c)]
             [else (backtrack (cdr s) new-size new-k)])))]
      [else 
       (let ([c (list-ref s i)])
         (loop (+ i 1) 
               (if (char-numeric? c)
                   (* size (- (char->integer c) 48))
                   (+ size 1))
               s))])))