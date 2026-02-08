(define (find-radius houses heaters)
  (define sorted-houses (sort houses <))
  (define sorted-heaters (sort heaters <))

  (define current-heaters sorted-heaters)
  (define max-min-dist 0)

  (for ([house-loc sorted-houses])
    (let loop ()
      (cond
        ((or (null? (cdr current-heaters))
             (> (cadr current-heaters) house-loc))
         (define h1 (car current-heaters))
         (define dist1 (abs (- house-loc h1)))

         (define dist2 (if (null? (cdr current-heaters))
                           +inf.0
                           (abs (- house-loc (cadr current-heaters)))))

         (set! max-min-dist (max max-min-dist (min dist1 dist2))))

        (else
         (set! current-heaters (cdr current-heaters))
         (loop)))))

  max-min-dist)