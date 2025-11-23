(define (robotSim commands obstacles)
  (define directions '((0 1) (1 0) (0 -1) (-1 0)))
  (define (move pos dir)
    (let* ((d (list-ref directions dir))
           (next (list (+ (car pos) (car d)) (+ (cadr pos) (cadr d)))))
      (if (member next obstacles)
          pos
          next)))
  (define (turn dir turn-dir)
    (modulo (+ dir turn-dir) 4))

  (define robot-pos '(0 0))
  (define robot-dir 0)
  (define max-dist 0)

  (for-each
   (lambda (cmd)
     (cond
       ((= cmd -2) (set! robot-dir (turn robot-dir -1)))
       ((= cmd -1) (set! robot-dir (turn robot-dir 1)))
       (else
        (for ((i (in-range cmd)))
          (set! robot-pos (move robot-pos robot-dir)))
        (set! max-dist (max max-dist (+ (car robot-pos) (cadr robot-pos)))))))
   commands)

  max-dist)

(define commands '(4 -1 3))
(define obstacles '())
(robotSim commands obstacles)