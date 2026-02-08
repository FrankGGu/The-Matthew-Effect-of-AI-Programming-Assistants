(define (min-add-to-make-valid s)
  (let loop ([s (string->list s)] [balance 0] [count 0])
    (cond
      [(empty? s) (+ count (abs balance))]
      [(char=? (car s) #\() (loop (cdr s) (+ balance 1) count)]
      [(char=? (car s) #\)) (if (> balance 0)
                                 (loop (cdr s) (- balance 1) count)
                                 (loop (cdr s) balance (+ count 1)))])))