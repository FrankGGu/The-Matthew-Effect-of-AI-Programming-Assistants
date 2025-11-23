(define (gridIllumination n lamps queries)
  (define lamp-set (make-hash))
  (for ([lamp lamps])
    (hash-set! lamp-set lamp #t))

  (define directions '((-1 -1) (-1 0) (-1 1) (0 -1) (0 0) (0 1) (1 -1) (1 0) (1 1)))

  (define (is-illuminated x y)
    (or (hash-ref lamp-set (list x y) #f)
        (for/or ([dx (map car directions)]
                  [dy (map cadr directions)])
          (hash-ref lamp-set (list (+ x dx) (+ y dy)) #f))))

  (define (turn-off-lamps x y)
    (for ([dx (map car directions)]
          [dy (map cadr directions)])
      (hash-remove! lamp-set (list (+ x dx) (+ y dy)))))

  (define results (for ([query queries])
                    (let ([x (car query)]
                          [y (cadr query)])
                      (define illuminated (is-illuminated x y))
                      (when illuminated
                        (turn-off-lamps x y))
                      (if illuminated 1 0))))

  results)

(define n 5)
(define lamps '((0 0) (1 1) (2 2)))
(define queries '((0 0) (1 0) (1 1) (1 2) (0 1)))
(gridIllumination n lamps queries)