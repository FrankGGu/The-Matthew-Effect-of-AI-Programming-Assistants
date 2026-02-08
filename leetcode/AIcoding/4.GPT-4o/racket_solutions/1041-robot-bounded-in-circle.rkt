(define (isRobotBounded instructions)
  (define (move pos dir)
    (cond
      ((equal? dir 0) (list (+ (car pos) 0) (+ (cadr pos) 1))) ; North
      ((equal? dir 1) (list (+ (car pos) 1) (+ (cadr pos) 0))) ; East
      ((equal? dir 2) (list (+ (car pos) 0) (- (cadr pos) 1))) ; South
      ((equal? dir 3) (list (- (car pos) 1) (+ (cadr pos) 0))))) ; West

  (define (turn dir action)
    (if (equal? action "G")
        dir
        (if (equal? action "L")
            (modulo (- dir 1) 4)
            (modulo (+ dir 1) 4))))

  (define (simulate instructions)
    (define pos (list 0 0))
    (define dir 0)
    (for-each (lambda (action)
                (set! dir (turn dir action))
                (set! pos (move pos dir)))
              instructions)
    (or (equal? pos (list 0 0)) (not (= dir 0))))

  (simulate instructions))