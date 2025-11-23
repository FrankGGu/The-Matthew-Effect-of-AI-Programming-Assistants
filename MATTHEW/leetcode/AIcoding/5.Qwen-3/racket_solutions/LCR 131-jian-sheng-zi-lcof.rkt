#lang racket

(define (maxValueAfterCutting n k)
  (define (helper lst)
    (if (null? lst)
        0
        (let* ((m (car lst))
               (rest (cdr lst))
               (new-lst (append rest (list (- m 1)) (list (- m 1)))))
          (+ m (helper new-lst)))))
  (helper (make-list k n)))