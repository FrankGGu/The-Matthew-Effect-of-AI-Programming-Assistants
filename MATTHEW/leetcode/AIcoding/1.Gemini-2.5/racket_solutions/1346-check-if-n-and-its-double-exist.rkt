(define (check-if-n-and-its-double-exist arr)
  (let ((seen (make-hash)))
    (for/or ((n arr))
      (let ((found-match
             (or
               (hash-has-key? seen (* 2 n))
               (and (zero? (remainder n 2))
                    (hash-has-key? seen (/ n 2))))))
        (hash-set! seen n #t)
        found-match))))