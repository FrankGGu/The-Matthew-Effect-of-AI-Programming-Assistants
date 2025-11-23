(define (min-operations logs)
  (let loop ([depth 0] [ls logs])
    (cond
      [(null? ls) depth]
      [(string=? (car ls) "../") (loop (max 0 (- depth 1)) (cdr ls))]
      [(string=? (car ls) "./") (loop depth (cdr ls))]
      [else (loop (+ depth 1) (cdr ls))])))