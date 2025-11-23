#lang racket

(require racket/list)

(define (find-min-difference timePoints)
  (define (time-string->minutes time-str)
    (define parts (string-split time-str ":"))
    (define hh (string->number (car parts)))
    (define mm (string->number (cadr parts)))
    (+ (* hh 60) mm))

  (define minutes-list (map time-string->minutes timePoints))
  (define sorted-minutes (sort minutes-list <))

  (define num-times (length sorted-minutes))
  (define min-diff 1440) ; Max possible difference is 720, so 1440 is a safe upper bound

  (for ([i (in-range (- num-times 1))])
    (set! min-diff (min min-diff (- (list-ref sorted-minutes (+ i 1)) (list-ref sorted-minutes i)))))

  ; Calculate difference between first and last, considering wrap-around
  (define first-time (car sorted-minutes))
  (define last-time (last sorted-minutes))
  (define wrap-around-diff (+ first-time 1440 (- last-time))) ; 1440 is minutes in a day

  (min min-diff wrap-around-diff))