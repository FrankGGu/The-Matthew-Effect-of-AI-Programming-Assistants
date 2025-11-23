(define (robotSim commands obstacles)
  (define (move pos dir)
    (match dir
      [(list 0 1) (list (car pos) (+ (cadr pos) 1))]
      [(list 1 0) (list (+ (car pos) 1) (cadr pos))]
      [(list 0 -1) (list (car pos) (- (cadr pos) 1))]
      [(-1 0) (list (- (car pos) 1) (cadr pos))]))

  (define (turn dir turn-dir)
    (match turn-dir
      [0 (list (cadr dir) (- (car dir)))]
      [1 (list (- (cadr dir)) (car dir))]))

  (define obstacles-set (set (map (lambda (o) (cons (car o) (cadr o))) obstacles)))
  (define pos (list 0 0))
  (define dir '(0 1))
  (define max-dist 0)

  (for ([command commands])
    (cond
      [(= command -2) (set! dir (turn dir 0))]
      [(= command -1) (set! dir (turn dir 1))]
      [else
       (for ([step (in-range command)])
         (let ([next-pos (move pos dir)])
           (if (not (set-member? obstacles-set next-pos))
               (set! pos next-pos)
               (break))))
       (set! max-dist (max max-dist (+ (* (car pos) (car pos)) (* (cadr pos) (cadr pos)))))]))
  max-dist)