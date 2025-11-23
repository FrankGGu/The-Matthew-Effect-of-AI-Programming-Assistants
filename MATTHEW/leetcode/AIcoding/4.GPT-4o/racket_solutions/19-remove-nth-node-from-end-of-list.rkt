#lang racket

(define-type ListNode
  (struct ListNode (val next)))

(define (removeNthFromEnd head n)
  (let loop ([first head] [second head] [count 0])
    (if (null? first)
        (let ([to-remove (- count n)])
          (if (zero? to-remove)
              (send second next)
              (let loop2 ([current head] [index 0])
                (if (null? current)
                    head
                    (if (= index (- to-remove 1))
                        (begin
                          (set-next (send current next) (send (send current next) next))
                          head)
                        (loop2 (send current next) (add1 index)))))))
        (loop (send first next) (if (zero? count) second (send second next)) (add1 count)))))

(define (set-next node next)
  (set! (next node) next))