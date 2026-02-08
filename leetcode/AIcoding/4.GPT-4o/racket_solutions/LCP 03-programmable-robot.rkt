(define (robotSim commands obstacles)
  (define (move pos dir)
    (if (and (not (null? obstacles))
             (member (list (+ (car pos) (car dir)) (+ (cadr pos) (cadr dir))) obstacles))
        pos
        (list (+ (car pos) (car dir)) (+ (cadr pos) (cadr dir)))))

  (define directions '((0 . 1) (1 . 0) (0 . -1) (-1 . 0)))
  (define (turn dir turn-dir)
    (modulo (+ dir turn-dir) 4))

  (define pos (list 0 0))
  (define dir 0)

  (for-each (lambda (cmd)
              (cond
                ((= cmd -2) (set! dir (turn dir -1)))
                ((= cmd -1) (set! dir (turn dir 1)))
                (else
                 (for ((i (in-range cmd)))
                   (set! pos (move pos (list-ref directions dir)))))))
            commands)

  (apply max (map (lambda (p) (+ (car p) (cadr p))) (list pos)))
)

(define (robotSimWrapper commands obstacles)
  (robotSim commands (map (lambda (x) (list (car x) (cadr x))) obstacles)))