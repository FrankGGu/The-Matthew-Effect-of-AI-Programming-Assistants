(define (max-depth s)
  (let loop ([str (string->list s)] [depth 0] [max-depth 0])
    (cond
      [(empty? str) max-depth]
      [(char=? (car str) #\() (loop (cdr str) (+ depth 1) (max (+ depth 1) max-depth))]
      [(char=? (car str) #\)) (loop (cdr str) (- depth 1) max-depth)]
      [else (loop (cdr str) depth max-depth)])))