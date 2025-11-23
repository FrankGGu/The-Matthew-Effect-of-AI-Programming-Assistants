(define (countHouses distance houses)
  (define (count-houses-helper d)
    (if (null? houses)
        0
        (let* ((first (car houses))
               (next-houses (cdr houses))
               (count (if (= first d) 1 0)))
          (+ count (count-houses-helper d next-houses)))))
  (count-houses-helper distance))

(define (countHouses distance houses)
  (countHouses distance (sort houses <)))