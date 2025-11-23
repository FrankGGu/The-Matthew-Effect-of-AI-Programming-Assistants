(define (can-build-boxes box-types box-amounts truck-size)
  (define (helper remaining-boxes truck-cap)
    (cond
      [(null? remaining-boxes) #t]
      [(> (car remaining-boxes) truck-cap) #f]
      [else
       (let* ((current-box (car remaining-boxes))
              (current-amount (car (cdr remaining-boxes)))
              (max-to-take (min current-amount truck-cap)))
         (or (helper (cdr remaining-boxes) (- truck-cap max-to-take))
             (and (> current-amount max-to-take)
                  (helper (cons current-box (- current-amount max-to-take)) 
                          (- truck-cap max-to-take))))))]))
  (helper box-amounts truck-size))

(define (canConstruct boxes truck-size)
  (let ((box-types (map car boxes))
        (box-amounts (map cadr boxes)))
    (can-build-boxes box-types box-amounts truck-size)))

(define (numBoxes boxes truckSize)
  (if (empty? boxes)
      0
      (let ((box-types (map car boxes))
            (box-amounts (map cadr boxes)))
        (if (can-build-boxes box-types box-amounts truckSize)
            (length boxes)
            0))))