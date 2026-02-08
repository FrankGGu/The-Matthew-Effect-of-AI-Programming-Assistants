(define (contain-virus grid)
  (define (neighbors i j)
    (filter (lambda (p) (and (>= (car p) 0) (< (car p) (length grid)) (>= (cdr p) 0) (< (cdr p) (length (first grid)))))
            (list (cons (- i 1) j) (cons (+ i 1) j) (cons i (- j 1)) (cons i (+ j 1)))))

  (define (bfs start-row start-col regions)
    (define visited (make-hash))
    (define queue (list (cons start-row start-col)))
    (define infected #f)
    (define perimeter 0)
    (define infected-regions (make-hash))

    (hash-set! visited (cons start-row start-col) #t)

    (let loop ()
      (if (null? queue)
          (values infected perimeter infected-regions)
          (let ((curr (car queue))
                (rest (cdr queue)))
            (let ((i (car curr))
                  (j (cdr curr)))
              (for-each (lambda (neighbor)
                          (let ((ni (car neighbor))
                                (nj (cdr neighbor)))
                            (cond
                              ((and (>= ni 0) (< ni (length grid)) (>= nj 0) (< nj (length (first grid))) (not (hash-has-key? visited (cons ni nj))))
                               (cond
                                 ((= (list-ref (list-ref grid i) j) 1)
                                  (hash-set! visited (cons ni nj) #t)
                                  (set! queue (append queue (list (cons ni nj)))))
                                 ((= (list-ref (list-ref grid i) j) 0)
                                  (set! perimeter (+ perimeter 1))
                                  (hash-set! infected-regions (cons ni nj) #t)))))))
                        (neighbors i j))
              (loop))))))

  (define (find-regions)
    (define visited (make-hash))
    (define regions '())
    (for/list ((i (in-range (length grid)))
               (j (in-range (length (first grid)))))
      (if (and (= (list-ref (list-ref grid i) j) 1) (not (hash-has-key? visited (cons i j))))
          (let-values (((infected perimeter infected-regions) (bfs i j visited)))
            (for-each (lambda (p) (hash-set! visited p #t)) (hash-keys visited))
            (list (cons i j) perimeter infected-regions))))))

  (define (contain-region region)
    (let ((start (first region)))
      (let ((i (car start))
            (j (cdr start)))
        (define visited (make-hash))
        (define queue (list (cons i j)))

        (hash-set! visited (cons i j) #t)

        (let loop ()
          (if (null? queue)
              #t
              (let ((curr (car queue))
                    (rest (cdr queue)))
                (let ((i (car curr))
                      (j (cdr curr)))
                  (for-each (lambda (neighbor)
                              (let ((ni (car neighbor))
                                    (nj (cdr neighbor)))
                                (cond
                                  ((and (>= ni 0) (< ni (length grid)) (>= nj 0) (< nj (length (first grid))) (not (hash-has-key? visited (cons ni nj))))
                                   (cond
                                     ((= (list-ref (list-ref grid ni) nj) 1)
                                      (hash-set! visited (cons ni nj) #t)
                                      (set! queue (append queue (list (cons ni nj)))))
                                     (else #f))))))
                            (neighbors i j))
                  (loop))))))))

  (define (spread-virus region)
     (for-each (lambda (p)
                 (let ((i (car p))
                       (j (cdr p)))
                   (if (and (>= i 0) (< i (length grid)) (>= j 0) (< j (length (first grid))))
                       (set! (list-ref (list-ref grid i) j) 1))))
               (hash-keys (third region))))

  (define (contain-all)
    (let loop ((firewalls 0))
      (let ((regions (filter identity (find-regions))))
        (if (null? regions)
            firewalls
            (let ((max-spread (apply max (map (lambda (region) (hash-count (third region))) regions))))
              (let ((contain-region (car (sort regions (lambda (a b) (> (hash-count (third a)) (hash-count (third b)))))))
                    (other-regions (cdr (sort regions (lambda (a b) (> (hash-count (third a)) (hash-count (third b))))))))

                (set! firewalls (+ firewalls (second contain-region)))

                (define start (first contain-region))
                (let ((i (car start))
                      (j (cdr start)))
                  (define visited (make-hash))
                  (define queue (list (cons i j)))

                  (hash-set! visited (cons i j) #t)

                  (let loop2 ()
                    (if (null? queue)
                        #t
                        (let ((curr (car queue))
                              (rest (cdr queue)))
                          (let ((i (car curr))
                                (j (cdr curr)))
                            (set! (list-ref (list-ref grid i) j) -1)
                            (for-each (lambda (neighbor)
                                        (let ((ni (car neighbor))
                                              (nj (cdr neighbor)))
                                          (cond
                                            ((and (>= ni 0) (< ni (length grid)) (>= nj 0) (< nj (length (first grid))) (not (hash-has-key? visited (cons ni nj))))
                                             (cond
                                               ((= (list-ref (list-ref grid ni) nj) 1)
                                                (hash-set! visited (cons ni nj) #t)
                                                (set! queue (append queue (list (cons ni nj))))))))))
                                      (neighbors i j))
                            (loop2))))))

                (for-each spread-virus other-regions)

                (for/list ((i (in-range (length grid)))
                           (j (in-range (length (first grid)))))
                  (if (= (list-ref (list-ref grid i) j) -1)
                      (set! (list-ref (list-ref grid i) j) 2)))

                (for/list ((i (in-range (length grid)))
                           (j (in-range (length (first grid)))))
                  (if (= (list-ref (list-ref grid i) j) 2)
                      (set! (list-ref (list-ref grid i) j) 1)))

                (loop firewalls))))))))

  (contain-all))