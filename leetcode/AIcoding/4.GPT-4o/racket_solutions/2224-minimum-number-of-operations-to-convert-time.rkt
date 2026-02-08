(define (convert-time current-time correct-time)
  (define (time->minutes time)
    (let* ((parts (map string->number (string-split time ":")))
           (hours (first parts))
           (minutes (second parts)))
      (+ (* hours 60) minutes)))

  (define current-minutes (time->minutes current-time))
  (define correct-minutes (time->minutes correct-time))
  (define diff (- correct-minutes current-minutes))
  (when (< diff 0) (set! diff (+ diff 1440)))

  (define operations 0)
  (define (reduce diff unit)
    (if (>= diff unit)
        (begin
          (set! operations (+ operations (quotient diff unit)))
          (set! diff (remainder diff unit))))
    diff)

  (reduce diff 60)
  (reduce diff 15)
  (reduce diff 5)
  (reduce diff 1)

  operations)