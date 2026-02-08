(define/contract (check-valid-string s)
  (-> string? boolean?)
  (let loop ([i 0] [low 0] [high 0])
    (cond
      [(= i (string-length s)) (<= 0 low)]
      [else
       (let ([c (string-ref s i)])
         (cond
           [(char=? c #\() (loop (+ i 1) (+ low 1) (+ high 1))]
           [(char=? c #\)) (loop (+ i 1) (- low 1) (- high 1))]
           [else (loop (+ i 1) (- low 1) (+ high 1))]))])))