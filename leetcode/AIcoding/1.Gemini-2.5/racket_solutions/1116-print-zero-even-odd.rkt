#lang racket/base
(require racket/sync)

(define *n* (box 0))
(define *current-num* (box 1))
(define *mutex* (make-mutex))
(define *cv-zero* (make-condition-variable))
(define *cv-even* (make-condition-variable))
(define *cv-odd* (make-condition-variable))

(define *zero-turn?* (box #t))
(define *even-turn?* (box #f))
(define *odd-turn?* (box #f))

(define (ZeroEvenOdd n)
  (set-box! *n* n)
  (set-box! *current-num* 1)
  (set-box! *zero-turn?* #t)
  (set-box! *even-turn?* #f)
  (set-box! *odd-turn?* #f))

(define (zero printNumber)
  (for ([i (in-range (unbox *n*))])
    (sync *mutex*
      (unless (unbox *zero-turn?*)
        (wait *cv-zero* *mutex*))

      (printNumber 0)
      (set-box! *zero-turn?* #f)

      (if (odd? (unbox *current-num*))
          (begin
            (set-box! *odd-turn?* #t)
            (signal *cv-odd*))
          (begin
            (set-box! *even-turn?* #t)
            (signal *cv-even*))))))

(define (even printNumber)
  (for ([i (in-range (floor (/ (unbox *n*) 2)))])
    (sync *mutex*
      (unless (unbox *even-turn?*)
        (wait *cv-even* *mutex*))

      (printNumber (unbox *current-num*))
      (set-box! *current-num* (+ (unbox *current-num*) 1))
      (set-box! *even-turn?* #f)
      (set-box! *zero-turn?* #t)
      (signal *cv-zero*))))

(define (odd printNumber)
  (for ([i (in-range (ceiling (/ (unbox *n*) 2)))])
    (sync *mutex*
      (unless (unbox *odd-turn?*)
        (wait *cv-odd* *mutex*))

      (printNumber (unbox *current-num*))
      (set-box! *current-num* (+ (unbox *current-num*) 1))
      (set-box! *odd-turn?* #f)
      (set-box! *zero-turn?* #t)
      (signal *cv-zero*))))