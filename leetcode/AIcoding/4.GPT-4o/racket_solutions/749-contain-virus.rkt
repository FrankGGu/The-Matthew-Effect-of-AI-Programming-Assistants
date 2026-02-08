(define (containVirus isInfected)
  (define (get-areas)
    (let loop ((i 0) (j 0) (infected '()) (borders '()) (count 0) (areas '()))
      (cond
        [(= i (length isInfected)) areas]
        [(= j (length (list-ref isInfected i))) (loop (+ i 1) 0 infected borders count (cons (list infected borders count) areas))]
        [(= (list-ref (list-ref isInfected i) j) 1)
         (let ((new-infected (cons (list i j) infected))
               (new-borders (foldl (lambda (pos acc)
                                       (for ([di '(-1 0 1 0)] [dj '(-1 0 0 1)])
                                         (let ((ni (+ (car pos) di))
                                               (nj (+ (cadr pos) dj)))
                                           (when (and (>= ni 0) (< ni (length isInfected))
                                                      (>= nj 0) (< nj (length (list-ref isInfected ni)))
                                                      (= (list-ref (list-ref isInfected ni) nj) 0))
                                             (set! acc (cons (list ni nj) acc))))))
                                     acc)
                                   new-infected))
               (new-count (+ count 1)))
           (loop i (+ j 1) new-infected new-borders new-count areas))]
        [else (loop i (+ j 1) infected borders count areas)])))

  (define (spread-virus areas)
    (for-each (lambda (area)
                (for-each (lambda (b)
                            (let* ((bi (car b))
                                   (bj (cadr b)))
                              (set! (list-ref (list-ref isInfected bi) bj) 1)))
                          (caddr area)))
              areas))

  (define (contain-area area)
    (for-each (lambda (i)
                (for-each (lambda (j)
                            (set! (list-ref (list-ref isInfected i) j) -1))
                          (car area)))
              (car area)))

  (define (simulate)
    (let loop ((areas (get-areas)))
      (if (null? areas)
          0
          (let* ((max-area (car (sort areas (lambda (a b) (> (caddr a) (caddr b))))))
                 (walls (caddr max-area)))
            (spread-virus areas)
            (contain-area max-area)
            (+ walls (loop (filter (lambda (x) (not (= x max-area))) areas)))))))

  (simulate))