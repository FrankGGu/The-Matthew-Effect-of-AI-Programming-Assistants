(define (min-coins coins)
  (let loop ([coins coins] [count 0])
    (cond
      [(empty? coins) count]
      [else
       (let* ([min-val (apply min coins)]
              [new-coins (map (lambda (c) (- c min-val)) coins)])
         (loop new-coins (+ count min-val)))])))