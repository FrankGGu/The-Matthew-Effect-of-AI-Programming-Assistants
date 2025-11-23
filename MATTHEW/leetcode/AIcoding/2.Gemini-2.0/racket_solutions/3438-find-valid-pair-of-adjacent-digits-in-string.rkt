(define (find-valid-pair s)
  (let loop ([i 0])
    (cond
      [(>= i (- (string-length s) 1)) #f]
      [else
       (let ([c1 (string-ref s i)]
             [c2 (string-ref s (+ i 1))])
         (if (char<=? c1 c2)
             (cons (string c1) (cons (string c2) '()))
             (loop (+ i 1))))])))