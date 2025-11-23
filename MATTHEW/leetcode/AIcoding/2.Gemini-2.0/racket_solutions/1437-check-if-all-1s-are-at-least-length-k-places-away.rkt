(define (k-length-apart nums k)
  (let loop ([lst nums] [last-one -100000])
    (cond
      [(null? lst) #t]
      [(= (car lst) 1)
       (if (>= (- (length nums) (length lst)) (+ last-one k 1))
           (loop (cdr lst) (- (length nums) (length lst)))
           #f)]
      [else (loop (cdr lst) last-one)])))