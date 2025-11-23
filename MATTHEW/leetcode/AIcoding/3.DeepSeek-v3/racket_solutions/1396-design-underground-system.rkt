(define underground-system%
  (class object%
    (super-new)
    (init-field)
    (define check-ins (make-hash))
    (define travels (make-hash))

    (define/public (check-in id station-name t)
      (hash-set! check-ins id (cons station-name t)))

    (define/public (check-out id station-name t)
      (define check-in-data (hash-ref check-ins id))
      (define start-station (car check-in-data))
      (define start-time (cdr check-in-data))
      (define key (string-append start-station "," station-name))
      (define current (hash-ref travels key (cons 0 0)))
      (hash-set! travels key (cons (+ (car current) (- t start-time)) (+ (cdr current) 1)))
      (hash-remove! check-ins id))

    (define/public (get-average-time start-station end-station)
      (define key (string-append start-station "," end-station))
      (define data (hash-ref travels key))
      (/ (car data) (cdr data)))))

(define (make-underground-system) (new underground-system%))