(define (largestTimeFromDigits A)
  (define (valid-time? h m)
    (and (<= 0 h 23) (<= 0 m 59)))

  (define (format-time h m)
    (string-append (number->string h) ":" (number->string m)))

  (define (check-permutation lst)
    (for/fold ([max-time ""]) ([perm (permutations lst)])
      (let* ([h (+ (* (list-ref perm 0) 10) (list-ref perm 1))]
             [m (+ (* (list-ref perm 2) 10) (list-ref perm 3))])
        (if (valid-time? h m)
            (let* ([current-time (format-time h m)])
              (if (string> current-time max-time) current-time max-time))
            max-time)))

  (check-permutation A))