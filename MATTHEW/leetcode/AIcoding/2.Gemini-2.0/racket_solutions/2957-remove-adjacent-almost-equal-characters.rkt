(define (remove-almost-equal-characters s)
  (let loop ([s (string->list s)] [count 0])
    (cond
      [(empty? s) count]
      [(empty? (cdr s)) count]
      [(<= (abs (- (char->integer (car s)) (char->integer (cadr s)))) 1)
       (loop (cddr s) (+ count 1))]
      [else (loop (cdr s) count)])))