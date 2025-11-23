#lang racket

(define (replace-question-marks s)
  (list->string
   (map (lambda (char)
          (if (char=? char #\?)
              #\a
              char))
        (string->list s))))