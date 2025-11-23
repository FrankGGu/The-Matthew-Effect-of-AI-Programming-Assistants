(define (cat-and-mouse-ii grid mouseJump catJump)
  (define n (length grid))
  (define m (length (car grid)))

  (define char-grid (map string->list grid))

  (define mouse-start-r -1)
  (define mouse-start-c -1)
  (define cat-start-r -1)
  (define cat-start-c -1)

  (for* ([r (range n)]
         [c (range m)])
    (case (list-ref (list-ref char-grid r) c)
      [#\M (set! mouse-start-r r) (set! mouse-start-c c)]
      [#\C (set! cat-start-r r) (set! cat-start-c c)]))

  (define memo (make-hash))

  (define (valid-pos? r c)
    (and (>= r 0) (< r n) (>= c 0) (< c m) (not (char=? (list-ref (list-ref char-grid r) c) #\#))))

  (define dirs '((-1 0) (1 0) (0 -1) (0 1)))

  (define (get-next-moves r c jump)
    (let ([moves (list (list r c))]) ; Always allow staying in place
      (for-each (lambda (dir)
                  (let ([dr (car dir)]
                        [dc (cadr dir)])
                    (for ([k (range 1 (+ jump 1))])
                      (let ([nr (+ r (* dr k))]
                            [nc (+ c (* dc k))])
                        (unless (valid-pos? nr nc)
                          (break)) ; Cannot move through obstacles, or off grid
                        (set! moves (cons (list nr nc) moves))))))
                dirs)
      (reverse moves)))

  ; Result: 0 (Draw), 1 (Mouse wins), 2 (Cat wins)
  (define (solve mr mc cr cc turn)
    (let ([key (list mr mc cr cc turn)])
      (cond
        [(hash-has-key? memo key) (hash-ref memo key)]
        [else
         (let ([result
                (cond
                  ; Base cases (order matters for priority)
                  ; If cat is on food, cat wins.
                  [(char=? (list-ref (list-ref char-grid cr) cc) #\F) 2]
                  ; If mouse is on food, mouse wins.
                  [(char=? (list-ref (list-ref char-grid mr) mc) #\F) 1]
                  ; If cat and mouse are on the same cell, cat wins.
                  [(and (= mr cr) (= mc cc)) 2]
                  ; Otherwise, compute recursively
                  [else
                   ; Mark current state as potentially a draw (visiting) for cycle detection
                   (hash-set! memo key 0) ; 0 represents DRAW / VISITING

                   (cond
                     [(zero? turn) ; Mouse's turn
                      (let ([mouse-wins-any #f]
                            [mouse-draws-any #f])
                        (for-each (lambda (next-m-pos)
                                    (let ([nmr (car next-m-pos)]
                                          [nmc (cadr next-m-pos)])
                                      (let ([next-res (cond
                                                        [(and (= nmr cr) (= nmc cc)) ; Mouse moves to cat's cell
                                                         (if (char=? (list-ref (list-ref char-grid cr) cc) #\F)
                                                             2 ; Cat wins if it's on food
                                                             0)] ; Draw otherwise
                                                        [else
                                                         (solve nmr nmc cr cc 1)])])
                                        (when (= next-res 1) (set! mouse-wins-any #t))
                                        (when (= next-res 0) (set! mouse-draws-any #t)))))
                                  (get-next-moves mr mc mouseJump))
                        (cond
                          [mouse-wins-any 1]
                          [mouse-draws-any 0]
                          [else 2])) ; All moves lead to cat win
                     [else ; Cat's turn
                      (let ([cat-wins-any #f]
                            [cat-draws-any #f])
                        (for-each (lambda (next-c-pos)
                                    (let ([ncr (car next-c-pos)]
                                          [ncc (cadr next-c-pos)])
                                      (let ([next-res (solve mr mc ncr ncc 0)])
                                        (when (= next-res 2) (set! cat-wins-any #t))
                                        (when (= next-res 0) (set! cat-draws-any #t)))))
                                  (get-next-moves cr cc catJump))
                        (cond
                          [cat-wins-any 2]
                          [cat-draws-any 0]
                          [else 1])))]))]
           (hash-set! memo key result)
           result)])))

  (solve mouse-start-r mouse-start-c cat-start-r cat-start-c 0))