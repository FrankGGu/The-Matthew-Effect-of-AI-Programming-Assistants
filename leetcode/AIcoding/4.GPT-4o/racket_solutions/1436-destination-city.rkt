(define (destCity paths)
  (define cities (map cdr paths))
  (define start-cities (map car paths))
  (define (find-destination city)
    (if (member city start-cities)
        #f
        city))
  (define destination (findf find-destination cities))
  destination)