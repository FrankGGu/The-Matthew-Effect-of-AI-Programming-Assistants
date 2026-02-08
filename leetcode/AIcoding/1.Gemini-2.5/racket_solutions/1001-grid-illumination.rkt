#lang racket

(define (grid-illumination n lamps queries)
  (define row-counts (make-hash))
  (define col-counts (make-hash))
  (define diag1-counts (make-hash)) ; r - c
  (define diag2-counts (make-hash)) ; r + c
  (define active-lamps (make-hasheq)) ; stores (list r c)

  (define (increment-count! ht key)
    (hash-update! ht key add1 0))

  (define (decrement-count! ht key)
    (hash-update! ht key sub1 0))

  (for-each (lambda (lamp)
              (define r (car lamp))
              (define c (cadr lamp))
              (define lamp-pos (list r c))
              (when (not (hasheq-contains? active-lamps lamp-pos))
                (hasheq-set! active-lamps lamp-pos #t)
                (increment-count! row-counts r)
                (increment-count! col-counts c)
                (increment-count! diag1-counts (- r c))
                (increment-count! diag2-counts (+ r c))))
            lamps)

  (define (process-query query)
    (define qr (car query))
    (define qc (cadr query))

    (define illuminated?
      (or (> (hash-ref row-counts qr 0) 0)
          (> (hash-ref col-counts qc 0) 0)
          (> (hash-ref diag1-counts (- qr qc) 0) 0)
          (> (hash-ref diag2-counts (+ qr qc) 0) 0)))

    (for* ([dr '(-1 0 1)]
           [dc '(-1 0 1)])
      (define nr (+ qr dr))
      (define nc (+ qc dc))
      (define neighbor-pos (list nr nc))

      (when (and (>= nr 0) (< nr n)
                 (>= nc 0) (< nc n)
                 (hasheq-contains? active-lamps neighbor-pos))
        (hasheq-remove! active-lamps neighbor-pos)
        (decrement-count! row-counts nr)
        (decrement-count! col-counts nc)
        (decrement-count! diag1-counts (- nr nc))
        (decrement-count! diag2-counts (+ nr nc))))

    (if illuminated? 1 0))

  (map process-query queries))