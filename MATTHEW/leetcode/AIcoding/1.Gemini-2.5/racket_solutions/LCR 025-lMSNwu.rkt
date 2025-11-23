#lang racket

(struct ListNode (val next))

(define (list->stack node)
  (let loop ((current node) (acc '()))
    (if (null? current)
        acc
        (loop (ListNode-next current) (cons (ListNode-val current) acc)))))

(define (add-two-numbers l1 l2)
  (define s1 (list->stack l1))
  (define s2 (list->stack l2))

  (let loop ((current-s1 s1) (current-s2 s2) (current-carry 0) (current-result-head null))
    (if (and (empty? current-s1) (empty? current-s2) (= current-carry 0))
        current-result-head
        (let* ((val1 (if (empty? current-s1) 0 (car current-s1)))
               (val2 (if (empty? current-s2) 0 (car current-s2)))
               (sum (+ val1 val2 current-carry))
               (new-digit (remainder sum 10))
               (next-carry (quotient sum 10))
               (new-node (ListNode new-digit current-result-head)))
          (loop (if (empty? current-s1) '() (cdr current-s1))
                (if (empty? current-s2) '() (cdr current-s2))
                next-carry
                new-node)))))