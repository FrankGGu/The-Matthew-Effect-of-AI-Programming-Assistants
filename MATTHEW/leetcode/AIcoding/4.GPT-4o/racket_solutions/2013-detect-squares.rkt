(define detect-squares
  (let ([points (make-hash)])
    (define (add point)
      (hash-set! points point (+ (hash-ref points point 0) 1)))
    (define (count-squares point)
      (define (distance-squared p1 p2)
        (+ (sqr (car p1) (- (car p2))) (sqr (cadr p1) (- (cadr p2)))))
      (define (valid-square? p1 p2)
        (define d (distance-squared p1 p2))
        (and (not (= d 0)) (= d (sqr (car p1) (cadr p2)) 4)))
      (for/sum ([p1 (hash-keys points)]
                 #:when (valid-square? point p1))
        (let ([x1 (car point)]
              [y1 (cadr point)]
              [x2 (car p1)]
              [y2 (cadr p1)])
          (if (and (not (= x1 x2)) (not (= y1 y2)))
              (* (hash-ref points p1) (hash-ref points (list x1 y2)))
              0))))
    (define (remove point)
      (hash-set! points point (max 0 (- (hash-ref points point 0) 1)))
      (when (= (hash-ref points point 0) 0)
        (hash-remove! points point)))
    (define (process op point)
      (cond
        [(equal? op 'add) (add point)]
        [(equal? op 'count) (count-squares point)]
        [(equal? op 'remove) (remove point)]))
    (lambda (op . args)
      (apply process op args)))