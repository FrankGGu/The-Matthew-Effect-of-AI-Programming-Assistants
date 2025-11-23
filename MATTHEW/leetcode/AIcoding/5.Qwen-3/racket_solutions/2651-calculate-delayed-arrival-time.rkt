(define (add-time time a)
  (let* ([h (string->number (substring time 0 2))]
         [m (string->number (substring time 3 5))]
         [total-min (+ (* h 60) m a)])
    (format "~a:~a" (quotient total-min 60) (modulo total-min 60))))

(define/contract (return-a-integer time a)
  (-> string? exact-integer? exact-integer?)
  (let* ([h (string->number (substring time 0 2))]
         [m (string->number (substring time 3 5))]
         [total-min (+ (* h 60) m a)])
    (quotient total-min 60)))