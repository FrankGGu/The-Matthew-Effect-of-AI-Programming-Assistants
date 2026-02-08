#lang racket

(define operations-on-tree%
  (class object%
    (super-new)

    (init-field (parent (vector)))

    (define/public (lock num user)
      (let ([ancestor num])
        (let loop ([ancestor ancestor])
          (cond
            [(= ancestor -1) #f]
            [(hash-ref locked ancestor #f) #t]
            [else (loop (vector-ref parent ancestor))])))
        (if (hash-ref locked num #f)
            #f
            (begin
              (hash-set! locked num user)
              #t)))

    (define/public (unlock num user)
      (if (equal? (hash-ref locked num #f) user)
          (begin
            (hash-remove! locked num)
            #t)
          #f))

    (define/public (upgrade num user)
      (let ([ancestor num])
        (let loop ([ancestor ancestor])
          (cond
            [(= ancestor -1) #f]
            [(equal? (hash-ref locked ancestor #f) user) #t]
            [else (loop (vector-ref parent ancestor))])))
        (let ([descendants (find-descendants num)])
          (let ([has-locked-descendant (ormap (lambda (d) (hash-ref locked d #f)) descendants)])
            (if (and (not (hash-ref locked num #f)) has-locked-descendant)
                (begin
                  (for ([d descendants])
                    (when (equal? (hash-ref locked d #f) user)
                      (hash-remove! locked d)))
                  (hash-set! locked num user)
                  #t)
                #f))))

    (define locked (make-hash))

    (define (find-descendants num)
      (let ([result '()])
        (let loop ([i 0])
          (when (< i (vector-length parent))
            (let ([p (vector-ref parent i)])
              (when (and (not (= p -1)) (= (vector-ref parent p) num))
                (set! result (cons i result))
                (set! result (append (find-descendants i) result))))
            (loop (add1 i))))
        result)))