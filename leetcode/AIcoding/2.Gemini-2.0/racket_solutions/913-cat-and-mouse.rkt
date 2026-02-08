(define (catMouse graph)
  (define n (vector-length graph))
  (define memo (make-hash))

  (define (get-key mouse cat turn)
    (string->symbol (format #f "~a-~a-~a" mouse cat turn)))

  (define (dfs mouse cat turn)
    (let ((key (get-key mouse cat turn)))
      (cond
        [(hash-has-key? memo key) (hash-ref memo key)]
        [(= mouse cat) 2]
        [(= mouse 0) 1]
        [(= turn (* 2 n)) 0]
        [else
         (let ([mouse-move (zero? (modulo turn 2))]
               [draw (if mouse-move 2 1)])
           (for ([neighbor (in-vector (vector-ref graph (if mouse-move mouse cat)))])
             (unless (and (not mouse-move) (= neighbor 0))
               (let ([next-mouse (if mouse-move neighbor mouse)]
                     [next-cat (if mouse-move cat neighbor)])
                 (let ([result (dfs next-mouse next-cat (+ turn 1))])
                   (cond
                     [(equal? result (if mouse-move 1 2))
                      (set! draw result)
                      (break)]
                     [else (set! draw (if mouse-move (min draw result) (max draw result)))])))))
           (hash-set! memo key draw)
           draw)])))

  (dfs 1 2 0))