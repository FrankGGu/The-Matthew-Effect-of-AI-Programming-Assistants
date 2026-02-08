#lang racket

(struct ListNode (val next) #:transparent)

(struct Solution (head)
  #:methods gen:solution-methods
  [
   (define (get-random this)
     (let* ((initial-head (Solution-head this))
            (initial-val (ListNode-val initial-head)))
       (let loop ((current (ListNode-next initial-head))
                  (count 1)
                  (result initial-val))
         (if (null? current)
             result
             (let* ((new-count (+ count 1))
                    (rand-val (random new-count)))
               (loop (ListNode-next current)
                     new-count
                     (if (= rand-val 0)
                         (ListNode-val current)
                         result)))))))
  ])