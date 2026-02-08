#lang racket

(define (my-atoi s)
  (define len (string-length s))
  (define i 0)
  (define sign 1)
  (define result 0)

  (define MAX_INT (- (expt 2 31) 1))
  (define MIN_INT (- (expt 2 31)))

  (let loop-skip-ws ((k i))
    (if (< k len)
        (if (char-whitespace? (string-ref s k))
            (loop-skip-ws (+ k 1))
            (set! i k))
        (set! i k)))

  (when (< i len)
    (let ((c (string-ref s i)))
      (cond
        ((char=? c #\-)
         (set! sign -1)
         (set! i (+ i 1)))
        ((char=? c #\+)
         (set! i (+ i 1))))))

  (let loop-read-digits ((k i))
    (when (< k len)
      (let ((c (string-ref s k)))
        (if (char-numeric? c)
            (let ((digit (- (char->integer c) (char->integer #\0))))
              (cond
                ((and (= sign 1)
                      (or (> result (/ MAX_INT 10))
                          (and (= result (/ MAX_INT 10)) (> digit (remainder MAX_INT 10)))))
                 (set! result MAX_INT)
                 (set! k len))
                ((and (= sign -1)
                      (or (> result (/ (abs MIN_INT) 10))
                          (and (= result (/ (abs MIN_INT) 10)) (> digit (remainder (abs MIN_INT) 10)))))
                 (set! result MIN_INT)
                 (set! k len))
                (else
                 (set! result (+ (* result 10) digit))
                 (loop-read-digits (+ k 1)))))
            (set! k len)))))

  (if (or (= result MAX_INT) (= result MIN_INT))
      result
      (* result sign)))