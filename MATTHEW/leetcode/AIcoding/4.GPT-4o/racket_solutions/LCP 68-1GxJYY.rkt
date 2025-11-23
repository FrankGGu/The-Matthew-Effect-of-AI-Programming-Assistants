(define (minBouquets bloomDay m k)
  (define (canMakeBouquets days)
    (define count 0)
    (define flowers 0)
    (for-each (lambda (bloom)
                (if (<= bloom days)
                    (begin (set! flowers (+ flowers 1))
                           (when (>= flowers k)
                             (set! count (+ count 1))
                             (set! flowers 0)))
                    (set! flowers 0)))
              bloomDay)
    (>= count m))

  (define low (apply min bloomDay))
  (define high (apply max bloomDay))

  (define (binary-search left right)
    (if (> left right)
        left
        (let ((mid (quotient (+ left right) 2)))
          (if (canMakeBouquets mid)
              (binary-search left (sub1 mid))
              (binary-search (add1 mid) right)))))

  (if (> (* m k) (length bloomDay))
      -1
      (binary-search low high)))

(minBouquets '(1 10 3 10 2) 3 1) ; Replace with actual test cases