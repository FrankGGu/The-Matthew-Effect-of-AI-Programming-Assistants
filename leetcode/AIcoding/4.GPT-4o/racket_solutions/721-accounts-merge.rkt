(define (accountsMerge accounts)
  (define (find parent x)
    (if (equal? (vector-ref parent x) x)
        x
        (set! (vector-ref parent x) (find parent (vector-ref parent x)))))

  (define (union parent rank x y)
    (let* ([rootX (find parent x)]
           [rootY (find parent y)])
      (when (not (equal? rootX rootY))
        (if (> (vector-ref rank rootX) (vector-ref rank rootY))
            (set! (vector-ref parent rootY) rootX)
            (begin
              (set! (vector-ref parent rootX) rootY)
              (when (= (vector-ref rank rootX) (vector-ref rank rootY))
                (set! (vector-ref rank rootY) (+ 1 (vector-ref rank rootY)))))))))

  (define parent (vector))
  (define rank (vector))
  (define email-to-name (hash))
  (define email-to-index (hash))

  (for ([account accounts])
    (let ([name (vector-ref account 0)])
      (hash-set! email-to-name (vector-ref account 1) name)
      (set! parent (vector-append parent (vector (index)))
      (set! rank (vector-append rank (vector 0)))
      (for ([i (in-range 2 (vector-length account))])
        (let ([email (vector-ref account i)])
          (hash-set! email-to-name email name)
          (union parent rank (index) (hash-ref email-to-index email (index)))
          (hash-set! email-to-index email (index)))))))

  (define root-to-emails (hash))
  (for ([i (in-range (vector-length parent))])
    (define root (find parent i))
    (hash-set! root-to-emails root (cons (hash-ref email-to-name (vector-ref parent i)) (hash-ref root-to-emails root (list))))
    (hash-update! root-to-emails root (lambda (emails) (sort (append emails (list (vector-ref parent i))) string<?)) '()))

  (map (lambda (emails)
         (cons (car emails) (sort (cdr emails) string<?)))
       (hash->list root-to-emails)))