#lang racket

(define (max-free-time intervals)
  (define (compare a b)
    (< (car a) (car b)))
  (define sorted (sort intervals compare))
  (define (loop prev-end result)
    (if (null? sorted)
        result
        (let* ((current (car sorted))
               (start (car current))
               (end (cadr current)))
          (if (<= start prev-end)
              (loop (max prev-end end) result)
              (loop end (+ result (- start prev-end)))))))
  (if (null? intervals)
      0
      (loop (caar intervals) 0)))