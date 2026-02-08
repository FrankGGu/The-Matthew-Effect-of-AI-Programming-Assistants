(define (rectangleArea rectangles)
  (define mod 1000000007)
  (define x-coords (map car rectangles))
  (define y-coords (map cadr rectangles))
  (define x-unique (sort (remove-duplicates x-coords) <))
  (define y-unique (sort (remove-duplicates y-coords) <))

  (define x-map (for/fold ([m (make-hash)]) ([x x-unique]) 
                    (hash-set! m x #t)))
  (define y-map (for/fold ([m (make-hash)]) ([y y-unique]) 
                    (hash-set! m y #t)))

  (define x-count (hash-count x-map))
  (define y-count (hash-count y-map))

  (define grid (make-vector (* x-count y-count) 0))

  (for ([rect rectangles])
    (define x1 (car rect))
    (define y1 (cadr rect))
    (define x2 (caddr rect))
    (define y2 (cadddr rect))

    (define x1-index (vector-ref x-map x1))
    (define x2-index (vector-ref x-map x2))
    (define y1-index (vector-ref y-map y1))
    (define y2-index (vector-ref y-map y2))

    (for ([x (in-range x1-index x2-index)])
      (for ([y (in-range y1-index y2-index)])
        (vector-set! grid (+ (* x-count y) x) 1))))

  (define area 0)
  (for ([x (in-range x-count)])
    (for ([y (in-range y-count)])
      (when (= (vector-ref grid (+ (* x-count y) x)) 1)
        (set! area (+ area (* (vector-ref x-unique x) (vector-ref y-unique y)))))))

  (modulo area mod))

(rectangleArea '((1 1 3 3) (2 2 4 4) (1 2 2 3)))