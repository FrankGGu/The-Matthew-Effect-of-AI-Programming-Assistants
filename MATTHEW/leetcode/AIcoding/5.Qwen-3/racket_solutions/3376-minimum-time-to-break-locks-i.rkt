#lang racket

(define (min-time-to-break-locks locks)
  (define (helper locks time)
    (if (null? locks)
        time
        (let* ([lock (car locks)]
               [key (cadr lock)]
               [time-to-break (caddr lock)])
          (if (= key 0)
              (helper (cdr locks) time)
              (helper (cdr locks) (+ time time-to-break))))))
  (helper locks 0))