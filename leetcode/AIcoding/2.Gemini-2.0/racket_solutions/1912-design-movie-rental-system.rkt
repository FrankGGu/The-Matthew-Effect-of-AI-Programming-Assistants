(define movie-rental-system%
  (class object%
    (init-field movies prices rented)

    (define/public (add-movie movie shop price)
      (hash-update! movies movie (lambda (v) (if v (hash-set v shop price) (hash shop price))) (hash)))

    (define/public (add-shop shop)
      (void))

    (define/public (rent movie shop)
      (if (and (hash-has-key? movies movie) (hash-has-key? (hash-ref movies movie) shop))
          (let* ((price (hash-ref (hash-ref movies movie) shop)))
            (hash-update! movies movie (lambda (v) (hash-remove v shop)) (hash))
            (hash-update! rented (list movie shop) (lambda (v) (if v (+ v 1) 1)) 0)
            (hash-set! prices (list movie shop) price)
            #t)
          #f))

    (define/public (drop movie shop)
      (if (and (hash-has-key? rented (list movie shop)))
          (let* ((price (hash-ref prices (list movie shop))))
            (hash-update! movies movie (lambda (v) (if v (hash-set v shop price) (hash shop price))) (hash))
            (hash-remove! rented (list movie shop))
            (hash-remove! prices (list movie shop))
            #t)
          #f))

    (define/public (report)
      (sort (map (lambda (k) (list (hash-ref prices k) (car k) (cadr k))) (hash-keys prices)) <))

    (define/public (search movie)
      (if (hash-has-key? movies movie)
          (sort (map car (hash-keys (hash-ref movies movie))) <)
          '()))

    (define/public (movies-at-shop shop)
      (let loop ((ks (hash-keys movies)) (res '()))
        (cond
          [(null? ks) (sort res <)]
          [else
           (let ((k (car ks)))
             (if (and (hash-has-key? movies k) (hash-has-key? (hash-ref movies k) shop))
                 (loop (cdr ks) (cons k res))
                 (loop (cdr ks) res)))])))
    ))

(define (make-movie-rental-system)
  (new movie-rental-system% [movies (hash)] [prices (hash)] [rented (hash)]))