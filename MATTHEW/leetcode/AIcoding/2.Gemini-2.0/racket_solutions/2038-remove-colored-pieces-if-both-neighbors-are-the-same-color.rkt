(define (winner-of-game colors)
  (let loop ([cs (string->list colors)]
             [alice-moves 0]
             [bob-moves 0])
    (cond
      [(null? cs)
       (> alice-moves bob-moves)]
      [(<= (length cs) 2)
       (> alice-moves bob-moves)]
      [else
       (let ([c1 (car cs)]
              [c2 (cadr cs)]
              [c3 (caddr cs)])
         (cond
           [(and (equal? c1 #\A) (equal? c2 #\A) (equal? c3 #\A))
            (loop (cdr cs) (+ 1 alice-moves) bob-moves)]
           [(and (equal? c1 #\B) (equal? c2 #\B) (equal? c3 #\B))
            (loop (cdr cs) alice-moves (+ 1 bob-moves))]
           [else
            (loop (cdr cs) alice-moves bob-moves)])))])))