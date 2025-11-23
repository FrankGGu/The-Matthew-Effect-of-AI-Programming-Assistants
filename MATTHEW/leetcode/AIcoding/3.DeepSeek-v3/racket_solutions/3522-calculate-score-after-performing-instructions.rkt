(define (calculate-instruction-score start-pos s)
  (let loop ([pos start-pos] [score 0] [s s])
    (if (null? s)
        score
        (let ([move (car s)])
          (cond
            [(eq? move 'L) (loop (sub1 pos) score (cdr s))]
            [(eq? move 'R) (loop (add1 pos) score (cdr s))]
            [(eq? move 'U) (loop pos (if (even? pos) (add1 score) score) (cdr s))]
            [(eq? move 'D) (loop pos (if (odd? pos) (add1 score) score) (cdr s))])))))