(define (min-moves-to-target box target)
  (let loop ((box box) (target target) (moves 0) (visited (set)))
    (if (equal? box target)
        moves
        (let ((next-boxes (list (list (+ (car box) 1) (cadr box))
                                 (list (- (car box) 1) (cadr box))
                                 (list (car box) (+ (cadr box) 1))
                                 (list (car box) (- (cadr box) 1)))))
          (for/fold ([min-moves +inf.0]) ([next-box next-boxes])
            (when (and (not (set-member? visited next-box))
                       (valid-box? next-box))
              (set-add! visited next-box)
              (loop next-box target (+ moves 1) visited)))))))

(define (valid-box? box)
  (and (>= (car box) 0) (>= (cadr box) 0)))

(define (minMovesToTarget box target)
  (min-moves-to-target box target))