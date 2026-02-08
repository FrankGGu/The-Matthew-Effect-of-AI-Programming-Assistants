(define (maxRunningTime n batteries)
  (define (canRunFor time)
    (define total (apply + (map (lambda (b) (min time b)) batteries)))
    (>= total (* n time)))

  (define (binarySearch low high)
    (if (= low high)
        low
        (let* ((mid (quotient (+ low high) 2)))
          (if (canRunFor mid)
              (binarySearch mid high)
              (binarySearch low mid)))))

  (binarySearch 0 (apply max batteries))
)