(define (get-max-len nums)
  (let loop ([nums nums] [pos 0] [neg 0] [max-len 0])
    (cond
      [(empty? nums) max-len]
      [else
       (let ([first (car nums)])
         (cond
           [(positive? first)
            (let ([new-pos (+ pos 1)]
                  [new-neg (if (zero? neg) 0 (+ neg 1))])
              (loop (cdr nums) new-pos new-neg (max max-len new-pos)))]
           [(negative? first)
            (let ([new-pos (if (zero? neg) 0 (+ neg 1))]
                  [new-neg (+ pos 1)])
              (loop (cdr nums) new-pos new-neg (max max-len new-neg)))]
           [else
            (loop (cdr nums) 0 0 max-len)]))])))