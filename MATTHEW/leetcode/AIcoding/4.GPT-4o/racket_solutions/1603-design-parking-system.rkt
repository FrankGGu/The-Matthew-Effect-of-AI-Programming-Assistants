(define parking-system
  (lambda (big medium small)
    (let ([big-count big]
          [medium-count medium]
          [small-count small])
      (define (add-car car-type)
        (cond
          [(= car-type 1) (if (> big-count 0)
                             (begin (set! big-count (- big-count 1)) #t)
                             #f)]
          [(= car-type 2) (if (> medium-count 0)
                             (begin (set! medium-count (- medium-count 1)) #t)
                             #f)]
          [(= car-type 3) (if (> small-count 0)
                             (begin (set! small-count (- small-count 1)) #t)
                             #f)]
          [else #f]))
      add-car)))

(define my-parking-system (parking-system 1 1 0))

(my-parking-system 1) ; returns #t
(my-parking-system 2) ; returns #t
(my-parking-system 3) ; returns #f
(my-parking-system 1) ; returns #f