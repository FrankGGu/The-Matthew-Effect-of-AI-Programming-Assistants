(define (min-operations logs)
  (let loop ([depth 0] [logs logs])
    (cond
      [(null? logs) depth]
      [(string=? (car logs) "../") (loop (max 0 (- depth 1)) (cdr logs))]
      [(string=? (car logs) "./") (loop depth (cdr logs))]
      [else (loop (+ depth 1) (cdr logs))])))