#lang racket

(define (min-cost-set-time startAt moveCost pushCost targetSeconds)
  (define (cost m s)
    (define digits (string->list (string-append (number->string m) (number->string s))))
    (define (helper prev total digits)
      (if (null? digits)
          total
          (let ((d (string->number (string (car digits)))))
            (helper d
                    (+ total
                       (if (equal? d prev) pushCost (+ moveCost pushCost)))
                    (cdr digits)))))
    (helper startAt 0 digits))

  (define (get-valid-times)
    (define valid '())
    (for ([m (in-range 0 100)])
      (for ([s (in-range 0 100)])
        (when (= (+ (* m 60) s) targetSeconds)
          (set! valid (cons (cons m s) valid)))))
    valid)

  (define valid-times (get-valid-times))
  (if (null? valid-times)
      (cost (quotient targetSeconds 60) (remainder targetSeconds 60))
      (apply min (map (lambda (p) (cost (car p) (cdr p))) valid-times))))