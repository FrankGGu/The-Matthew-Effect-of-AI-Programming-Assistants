#lang racket

(struct ListNode (val next) #:transparent)

(define (maximum-twin-sum head)
  (let loop ((current head) (vals-reversed '()))
    (if (not current)
        (let* ((vals (reverse vals-reversed))
               (n (length vals))
               (max-s 0))
          (for ((i (in-range (/ n 2))))
            (set! max-s (max max-s (+ (list-ref vals i) (list-ref vals (- n 1 i))))))
          max-s)
        (loop (ListNode-next current) (cons (ListNode-val current) vals-reversed)))))