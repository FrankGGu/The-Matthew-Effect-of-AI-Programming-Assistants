(define (longest-increasing-path matrix)
  (define rows (length matrix))
  (define cols (length (first matrix)))

  (define memo (make-vector (* rows cols) #f))

  (define (dfs r c)
    (cond
      [(vector-ref memo (+ (* r cols) c)) (vector-ref memo (+ (* r cols) c))]
      [else
       (let* ([curr (list-ref (list-ref matrix r) c)]
              [up (if (and (> r 0) (> (list-ref (list-ref matrix (- r 1)) c) curr)) (dfs (- r 1) c) 0)]
              [down (if (and (< r (- rows 1)) (> (list-ref (list-ref matrix (+ r 1)) c) curr)) (dfs (+ r 1) c) 0)]
              [left (if (and (> c 0) (> (list-ref (list-ref matrix r) (- c 1)) curr)) (dfs r (- c 1)) 0)]
              [right (if (and (< c (- cols 1)) (> (list-ref (list-ref matrix r) (+ c 1)) curr)) (dfs r (+ c 1)) 0)]
              [max-len (+ 1 (max up down left right))])
         (vector-set! memo (+ (* r cols) c) max-len)
         max-len)]))

  (let loop ([r 0] [c 0] [max-path 0])
    (cond
      [(>= r rows) max-path]
      [(>= c cols) (loop (+ r 1) 0 max-path)]
      [else (loop r (+ c 1) (max max-path (dfs r c)))])))