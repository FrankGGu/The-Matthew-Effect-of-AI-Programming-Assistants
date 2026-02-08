(define (robot-sim commands obstacles)
  (define/contract (step x y dir max-sq)
    (-> (integer? integer? integer? integer?) integer?)
    (cond
      [(null? commands) max-sq]
      [else
       (let* ([command (car commands)]
              [new-dir (cond
                         [(= command -2) (modulo (- dir 1) 4)]
                         [(= command -1) (modulo (+ dir 1) 4)]
                         [else dir])]
              [new-x x]
              [new-y y]
              [new-max-sq max-sq])
         (if (or (= command -1) (= command -2))
             (step x y new-dir max-sq)
             (let loop ([i 0] [cx x] [cy y])
               (if (= i command)
                   (step cx cy dir (max max-sq (+ (* cx cx) (* cy cy))))
                   (let* ([next-x (cond
                                    [(= dir 0) (+ cx 1)]
                                    [(= dir 2) (- cx 1)]
                                    [else cx])]
                          [next-y (cond
                                    [(= dir 1) (+ cy 1)]
                                    [(= dir 3) (- cy 1)]
                                    [else cy])]
                          [obstacle-found? (ormap (lambda (obs)
                                                      (and (= (car obs) next-x) (= (cadr obs) next-y)))
                                                    obstacles)])
                     (if obstacle-found?
                         (step cx cy dir (max max-sq (+ (* cx cx) (* cy cy))))
                         (loop (+ i 1) next-x next-y))))))])))
    )
  (step 0 0 0 0))