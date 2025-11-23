#lang racket

(define (minimum-teachers people)
  (define (count-people lang)
    (for/sum ([p people])
      (if (member lang p) 1 0)))
  (define langs (apply append people))
  (define unique-lang (remove-duplicates langs))
  (define (helper lst)
    (cond [(null? lst) 0]
          [else
           (let* ([lang (car lst)]
                  [cnt (count-people lang)])
             (if (= cnt 0)
                 (helper (cdr lst))
                 (+ 1 (helper (filter (lambda (x) (not (equal? x lang))) (cdr lst))))))]))
  (helper unique-lang))