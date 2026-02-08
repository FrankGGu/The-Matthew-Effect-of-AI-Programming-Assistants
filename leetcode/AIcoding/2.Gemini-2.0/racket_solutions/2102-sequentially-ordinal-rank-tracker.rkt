(define (make-SORTracker)
  (let ([data '()]
        [idx 0])
    (define (add score)
      (set! data (sort (cons score data) <)))
    (define (getRanked)
      (set! idx (+ idx 1))
      (list-ref data (- idx 1)))
    (lambda (op . args)
      (cond
        [(equal? op 'add) (add (car args))]
        [(equal? op 'getRanked) (getRanked)]))))

(define SORTracker make-SORTracker)