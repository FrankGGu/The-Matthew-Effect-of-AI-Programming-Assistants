(define (findNthDigit n)
  (define (digitLength k)
    (if (<= k 9)
        1
        (+ 1 (digitLength (inexact->exact (/ k 10))))))

  (define (countNumbers d)
    (* d (expt 10 (- d 1))))

  (define (findDigit n)
    (define d 1)
    (define count 9)
    (define start 1)
    (define total 0)

    (while (> n count)
      (set! n (- n count))
      (set! d (+ d 1))
      (set! count (* d 9 (expt 10 (- d 1))))
      (set! start (+ start count)))

    (set! start (+ start (inexact->exact (/ (- n 1) d))))
    (set! digit (remainder (- n 1) d))

    (define number (+ start (if (= d 1) 0 1)))
    (define result (integer->string number))
    (if (= digit 0)
        (string->number (substring result digit digit))
        (string->number (substring result digit digit))))

  (findDigit n))