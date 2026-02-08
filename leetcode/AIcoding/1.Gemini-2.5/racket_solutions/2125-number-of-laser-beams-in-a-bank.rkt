#lang racket

(define (number-of-laser-beams bank)
  (car (for/fold ((total-beams 0)
                  (prev-row-devices 0))
                 ((row bank))
         (let ((current-row-devices (count (lambda (c) (char=? c #\1)) (string->list row))))
           (if (> current-row-devices 0)
               (values (+ total-beams (* prev-row-devices current-row-devices))
                       current-row-devices)
               (values total-beams
                       prev-row-devices))))))