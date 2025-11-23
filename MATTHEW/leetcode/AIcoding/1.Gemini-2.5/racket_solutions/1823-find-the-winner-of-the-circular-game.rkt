(define (find-the-winner n k)
  (define (josephus-0-indexed num-friends step)
    (if (= num-friends 1)
        0
        (modulo (+ (josephus-0-indexed (- num-friends 1) step) step) num-friends)))
  (+ (josephus-0-indexed n k) 1))