(define animal%
  (class object%
    (super-new)

    (init-field [name ""]
                [age 0]
                [species ""])

    (define/public (get-name)
      name)

    (define/public (get-age)
      age)

    (define/public (get-species)
      species)

    (define/public (set-name new-name)
      (set! name new-name)
      this)

    (define/public (set-age new-age)
      (set! age new-age)
      this)

    (define/public (set-species new-species)
      (set! species new-species)
      this)))

(define (make-animal)
  (new animal%))