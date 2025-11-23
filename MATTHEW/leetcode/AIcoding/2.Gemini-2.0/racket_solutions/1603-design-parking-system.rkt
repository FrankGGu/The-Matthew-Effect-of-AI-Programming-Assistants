(define parking-system%
  (class object%
    (init big medium small)
    (super-new)
    (define big-count big)
    (define medium-count medium)
    (define small-count small)
    (define/public (add-car car-type)
      (cond
        [(equal? car-type 1)
         (if (> big-count 0)
             (begin (set! big-count (- big-count 1)) #t)
             #f)]
        [(equal? car-type 2)
         (if (> medium-count 0)
             (begin (set! medium-count (- medium-count 1)) #t)
             #f)]
        [(equal? car-type 3)
         (if (> small-count 0)
             (begin (set! small-count (- small-count 1)) #t)
             #f)]
        [else #f]))))

(define (make-parking-system big medium small)
  (new parking-system% big medium small))