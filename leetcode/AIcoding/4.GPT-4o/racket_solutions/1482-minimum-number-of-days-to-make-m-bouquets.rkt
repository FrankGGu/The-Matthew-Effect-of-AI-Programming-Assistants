(define (minDays bloomDay m k)
  (define (canMakeBouquets days)
    (let loop ((count 0) (bouquets 0) (index 0))
      (cond ((>= index (length bloomDay)) (= bouquets m))
            (else
              (if (>= (list-ref bloomDay index) days)
                  (loop count bouquets (+ index 1))
                  (loop (+ count 1) (if (>= (+ count 1) k) (+ bouquets 1) bouquets) (+ index 1)))))))

  (define low (apply min bloomDay))
  (define high (apply max bloomDay))

  (define (binarySearch low high)
    (if (> low high)
        -1
        (let* ((mid (quotient (+ low high) 2))
               (canMake (canMakeBouquets mid)))
          (cond ((and canMake (= mid high)) mid)
                ((and canMake (not (= mid high))) (binarySearch low mid))
                (else (binarySearch (+ mid 1) high))))))

  (binarySearch low high))

(define (minDaysWrapper bloomDay m k)
  (if (or (= m 0) (= k 0)) 0
      (minDays bloomDay m k)))