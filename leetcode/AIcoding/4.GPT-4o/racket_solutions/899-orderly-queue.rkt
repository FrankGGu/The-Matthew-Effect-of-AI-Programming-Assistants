(define (orderlyQueue s k)
  (if (= k 1)
      (apply string-append (sort (map string->list (map string->vector (string->list s))) string<?))
      (apply string-append (sort (string->list s) string<?))))