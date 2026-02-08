(define parking-system%
  (class object%
    (super-new)
    (init-field big medium small)
    (define big-slots big)
    (define medium-slots medium)
    (define small-slots small)

    (define/public (add-car car-type)
      (cond
        [(= car-type 1) (if (> big-slots 0)
                            (begin (set! big-slots (- big-slots 1)) #t)
                            #f)]
        [(= car-type 2) (if (> medium-slots 0)
                            (begin (set! medium-slots (- medium-slots 1)) #t)
                            #f)]
        [(= car-type 3) (if (> small-slots 0)
                            (begin (set! small-slots (- small-slots 1)) #t)
                            #f)]
        [else #f]))))