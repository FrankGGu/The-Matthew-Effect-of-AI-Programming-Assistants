(define (canMouseWin grid catJump mouseJump)
  (define rows (vector-length grid))
  (define cols (vector-length (vector-ref grid 0))))

  (define (find-char ch)
    (for/first ([i (in-range rows)]
                [j (in-range cols)])
      (when (char=? ch (vector-ref (vector-ref grid i) j))
        (cons i j))))

  (define food (find-char #\F))
  (define mouse (find-char #\M))
  (define cat (find-char #\C))

  (define (valid? pos)
    (and (>= (car pos) 0) (< (car pos) rows)
         (>= (cdr pos) 0) (< (cdr pos) cols)
         (not (char=? #\# (vector-ref (vector-ref grid (car pos)) (cdr pos))))))

  (define memo (make-hash))

  (define (solve mouse cat turn)
    (cond
      [(equal? mouse food) #t]
      [(equal? mouse cat) #f]
      [(> turn (* rows cols 2)) #f]
      [else
       (let ([key (list (car mouse) (cdr mouse) (car cat) (cdr cat) turn)])
         (cond
           [(hash-has-key? memo key) (hash-ref memo key)]
           [else
            (let* ([mouse-turn? (even? turn)]
                   [moves (if mouse-turn? mouse cat)]
                   [jump (if mouse-turn? mouseJump catJump)]
                   [result (if mouse-turn?
                               (for/or ([i (in-range (+ jump 1))])
                                 (for/or ([dx (list i (- i))])
                                   (for/or ([dy (list (- i) i)])
                                     (and (not (zero? (+ dx dy)))
                                          (let ([new-mouse (cons (+ (car moves) dx) (+ (cdr moves) dy))])
                                            (cond
                                              [(not (valid? new-mouse)) #f]
                                              [else (solve new-mouse cat (+ turn 1))]))))))
                               (for/and ([i (in-range (+ jump 1))])
                                 (for/and ([dx (list i (- i))])
                                   (for/and ([dy (list (- i) i)])
                                     (and (not (zero? (+ dx dy)))
                                          (let ([new-cat (cons (+ (car moves) dx) (+ (cdr moves) dy))])
                                            (cond
                                              [(not (valid? new-cat)) #t]
                                              [else (solve mouse new-cat (+ turn 1))]))))))))])
              (hash-set! memo key result)
              result)]))]))))

  (solve mouse cat 0))