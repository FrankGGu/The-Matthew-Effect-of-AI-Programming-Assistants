#lang racket

(define (daysBetweenDates date1 date2)
  (define (parse-date date)
    (map string->number (string-split date "-")))

  (define (days-in-year year)
    (if (and (= (modulo year 4) 0) (not (= (modulo year 100) 0)))
        366
        365))

  (define (days-from-epoch year month day)
    (define days (apply + (map days-in-year (range 1970 year))))
    (define days-in-month (list 0 31 (if (and (= (modulo year 4) 0) (not (= (modulo year 100) 0))) 29 28) 31 30 31 30 31 31 30 31 30 31))
    (define days-in-this-year (apply + (take days-in-month month)))
    (+ days days-in-this-year day))

  (define date1-parsed (parse-date date1))
  (define date2-parsed (parse-date date2))

  (define days1 (apply days-from-epoch date1-parsed))
  (define days2 (apply days-from-epoch date2-parsed))

  (abs (- days1 days2)))

(define date1 "2020-01-15")
(define date2 "2019-12-31")
(display (daysBetweenDates date1 date2))