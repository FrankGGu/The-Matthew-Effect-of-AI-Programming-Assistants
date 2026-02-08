(define (robotSim commands obstacles)
  (define directions '((0 1) (1 0) (0 -1) (-1 0)))
  (define (move pos dir)
    (let* ((dx (car (list-ref directions dir)))
           (dy (cadr (list-ref directions dir)))
           (new-pos (list (+ (car pos) dx) (+ (cadr pos) dy))))
      new-pos))
  (define (turn-right dir)
    (modulo (+ dir 1) 4))
  (define (turn-left dir)
    (modulo (- dir 1) 4))

  (define obstacle-set (set-of obstacles))
  (define current-pos '(0 0))
  (define current-dir 0)
  (define max-dist 0)

  (for-each (lambda (cmd)
              (cond
                ((= cmd -1) (set! current-dir (turn-right current-dir)))
                ((= cmd 1) (set! current-dir (turn-left current-dir)))
                (else
                 (for ((i (in-range cmd)))
                   (let ((next-pos (move current-pos current-dir)))
                     (if (set-member? obstacle-set next-pos)
                         (begin)
                         (begin
                           (set! current-pos next-pos)
                           (set! max-dist (max max-dist (+ (* (car next-pos) (car next-pos)) 
                                                            (* (cadr next-pos) (cadr next-pos)))))))))))))
            commands)

  max-dist)