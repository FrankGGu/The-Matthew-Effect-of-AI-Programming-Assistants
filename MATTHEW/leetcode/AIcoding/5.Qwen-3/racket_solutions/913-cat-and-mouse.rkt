#lang racket

(define (cat-mouse-game a)
  (define mouse-pos (car a))
  (define cat-pos (cadr a))
  (define home (caddr a))
  (define moves '((2 0) (-1 1) (1 1) (0 2)))
  (define (valid? x y)
    (and (>= x 0) (< x 5) (>= y 0) (< y 5)))
  (define (get-cell x y)
    (if (or (= x (car home)) (= y (cadr home))) 2
        (if (or (= x (car mouse-pos)) (= y (cadr mouse-pos))) 1
            0)))
  (define (dfs mpos cpos turn)
    (cond [(equal? mpos cpos) 2]
          [(equal? mpos home) 1]
          [(= turn 30) 0]
          [else
           (let ([m-x (car mpos)]
                 [m-y (cadr mpos)]
                 [c-x (car cpos)]
                 [c-y (cadr cpos)])
             (if (even? turn)
                 (let ([res 2])
                   (for-each
                    (lambda (move)
                      (let ([new-mx (+ m-x (car move))]
                            [new-my (+ m-y (cadr move))])
                        (when (valid? new-mx new-my)
                          (set! res (min res (dfs (list new-mx new-my) (list c-x c-y) (+ turn 1))))))
                    moves)
                   res)
                 (let ([res 1])
                   (for-each
                    (lambda (move)
                      (let ([new-cx (+ c-x (car move))]
                            [new-cy (+ c-y (cadr move))])
                        (when (valid? new-cx new-cy)
                          (set! res (max res (dfs (list m-x m-y) (list new-cx new-cy) (+ turn 1))))))
                    moves)
                   res))]))
  (dfs mouse-pos cat-pos 0))