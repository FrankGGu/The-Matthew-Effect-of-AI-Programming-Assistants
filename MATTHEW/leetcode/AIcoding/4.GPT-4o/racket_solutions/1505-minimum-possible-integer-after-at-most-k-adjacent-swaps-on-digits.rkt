(define (minInteger num k)
  (define (swap lst i j)
    (let ((temp (list-ref lst i)))
      (list-set! lst i (list-ref lst j))
      (list-set! lst j temp)
      lst))

  (define (bubble-sort lst k)
    (for/fold ([k k] [sorted lst]) ([i (in-range (sub1 (length lst)))])
      (if (or (zero? k) (not (< (list-ref sorted i) (list-ref sorted (add1 i)))))
          sorted
          (begin
            (set! sorted (swap sorted i (add1 i)))
            (set! k (sub1 k))
            sorted)))

  (define digits (map string->number (string-split num "")))
  (define len (length digits))
  (for ([i (in-range len)])
    (let ([j (min (+ i k) (sub1 len))])
      (for ([p (in-range j i -1)])
        (when (> (list-ref digits p) (list-ref digits i))
          (set! digits (swap digits p i))
          (set! k (sub (- p i) k))
          (break)))))
  (apply string-append (map number->string digits)))

(minInteger "4321" 4)