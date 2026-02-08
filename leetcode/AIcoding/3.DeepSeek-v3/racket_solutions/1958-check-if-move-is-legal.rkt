(define (is-legal board rMove cMove color)
  (define directions '((-1 -1) (-1 0) (-1 1) (0 -1) (0 1) (1 -1) (1 0) (1 1)))
  (define (valid? r c)
    (and (>= r 0) (< r 8) (>= c 0) (< c 8)))
  (define (check-direction dr dc)
    (let loop ((r (+ rMove dr)) (c (+ cMove dc)) (found-opposite? #f))
      (cond
        [(not (valid? r c)) #f]
        [(char=? (string-ref (list-ref board r) c) #\.) #f]
        [(char=? (string-ref (list-ref board r) c) color) found-opposite?]
        [else (loop (+ r dr) (+ c dc) #t)])))
  (for/or ([dir directions])
    (check-direction (car dir) (cadr dir))))