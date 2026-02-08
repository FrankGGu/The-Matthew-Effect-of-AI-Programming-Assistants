#lang racket

(define (judgePoint24 cards)
  (define epsilon 1e-6)

  (define (solve nums)
    (cond
      [(null? nums) #f]
      [(= (length nums) 1) (< (abs (- (car nums) 24)) epsilon)]
      [else
       (let loop ([i 0] [rest (cdr nums)])
         (if (>= i (length nums))
             #f
             (let* ([a (list-ref nums i)]
                    [new-nums (append (take nums i) (drop nums (add1 i))])
               (for/or ([b new-nums])
                 (let* ([new-new-nums (remove b new-nums)]
                        [ops (list + - * /)])
                   (for/or ([op ops])
                     (let ([res (op a b)])
                       (and (not (and (eq? op /) (< (abs b) epsilon)))
                            (solve (cons res new-new-nums))))))
               (loop (add1 i) rest)))))]))

  (solve (map exact->inexact cards)))