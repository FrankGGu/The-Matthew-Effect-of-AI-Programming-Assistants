#lang racket

(define (my-atoi s)
  (define len (string-length s))
  (define i 0)
  (define sign 1)
  (define result 0)
  (define clamped #f) ; Flag to indicate if result has been clamped due to overflow
  (define max-int (- (expt 2 31) 1))
  (define min-int (- (expt 2 31)))

  ;; 1. Read and ignore any leading whitespace
  (while (and (< i len) (char-whitespace? (string-ref s i)))
    (set! i (+ i 1)))

  ;; 2. Check if the next character is '-' or '+'.
  (when (< i len)
    (case (string-ref s i)
      [#\- (set! sign -1) (set! i (+ i 1))]
      [#\+ (set! i (+ i 1))]
      [else #f])) ; Do nothing if not a sign character

  ;; 3. Read digits until a non-digit character or end of string
  (while (and (< i len) (char-numeric? (string-ref s i)))
    (define digit (- (char->integer (string-ref s i)) (char->integer #\0)))

    ;; Check for overflow before adding the current digit
    (cond
      ;; Positive overflow check
      [(and (= sign 1)
            (or (> result (/ max-int 10))
                (and (= result (/ max-int 10)) (> digit (remainder max-int 10)))))
       (set! result max-int)
       (set! clamped #t)
       (set! i len) ; Stop further processing
       ]
      ;; Negative overflow check
      [(and (= sign -1)
            (or (> result (/ (- min-int) 10))
                (and (= result (/ (- min-int) 10)) (> digit (remainder (- min-int) 10)))))
       (set! result min-int)
       (set! clamped #t)
       (set! i len) ; Stop further processing
       ]
      ;; No overflow, continue building the number
      [else
       (set! result (+ (* result 10) digit))
       (set! i (+ i 1))]))

  ;; 5. Apply sign or return clamped value
  (if clamped
      result
      (* result sign)))