#lang racket

(define (find-min-difference timePoints)
  ;; Helper to convert "HH:MM" string to minutes from midnight
  (define (time-to-minutes time-str)
    (let* ([parts (string-split time-str ":")]
           [hours (string->number (car parts))]
           [minutes (string->number (cadr parts))])
      (+ (* hours 60) minutes)))

  ;; Convert all time strings to minutes
  (define minutes-list (map time-to-minutes timePoints))

  ;; Sort the list of minutes
  (define sorted-minutes (sort minutes-list <))

  ;; Initialize minimum difference to a value larger than any possible difference (1440 minutes in a day)
  (define min-diff 1440)

  ;; Calculate differences between adjacent time points
  (for ([i (in-range (sub1 (length sorted-minutes)))])
    (set! min-diff (min min-diff (- (list-ref sorted-minutes (add1 i)) (list-ref sorted-minutes i)))))

  ;; Calculate the difference between the first and last time point, considering wrap-around
  (define first-time (car sorted-minutes))
  (define last-time (list-ref sorted-minutes (sub1 (length sorted-minutes))))
  (define wrap-around-diff (- (+ 1440 first-time) last-time))

  ;; Return the overall minimum difference
  (min min-diff wrap-around-diff))