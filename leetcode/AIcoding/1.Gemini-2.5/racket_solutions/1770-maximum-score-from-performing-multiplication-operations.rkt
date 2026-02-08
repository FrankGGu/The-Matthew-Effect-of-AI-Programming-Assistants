#lang racket

(define (maximum-score-from-performing-multiplication-operations nums multipliers)
  (define n (length nums))
  (define m (length multipliers))

  (define nums-vec (list->vector nums))
  (define multipliers-vec (list->vector multipliers))

  (define memo (make-hash))

  (define (solve i left)
    (cond
      [(= i m) 0]
      [else
       (let ([key (cons i left)])
         (cond
           [(hash-has-key? memo key) (hash-ref memo key)]
           [else
            (let* ([right (+ (- n 1) left (- i))]
                   [score-pick-left (+ (* (vector-ref nums-vec left) (vector-ref multipliers-vec i))
                                       (solve (+ i 1) (+ left 1)))]
                   [score-pick-right (+ (* (vector-ref nums-vec right) (vector-ref multipliers-vec i))
                                        (solve (+ i 1) left))])
              (let ([result (max score-pick-left score-pick-right)])
                (hash-set! memo key result)
                result)))]))]))

  (solve 0 0))