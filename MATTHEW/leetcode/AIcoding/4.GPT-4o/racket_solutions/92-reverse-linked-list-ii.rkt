#lang racket

(define (reverseBetween head m n)
  (if (or (null? head) (<= m n))
      head
      (let loop ([current head] [prev #f] [i 1])
        (cond
          [(= i m)
           (let ([con prev]
                 [tail current])
             (let loop2 ([i i] [current current] [prev #f])
               (if (<= i n)
                   (let ([next (cdr current)])
                     (set-cdr! current prev)
                     (loop2 (add1 i) next current)
                     )
                   (begin
                     (if con
                         (set-cdr! con current))
                     (set-cdr! tail (cdr current))
                     (if (= m 1) current tail)))))]
          [else (loop (cdr current) current (add1 i))]))))

(struct ListNode (val next) #:transparent)