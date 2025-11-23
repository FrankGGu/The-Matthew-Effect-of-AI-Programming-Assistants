#lang racket

(struct ListNode (val next))

(define (reverse-nodes-in-even-length-groups head)
  (define (group-nodes start length)
    (if (null? start)
        (values '() 0)
        (let loop ((node start) (count 0) (group '()))
          (if (and (even? length) (zero? (modulo count length)))
              (values (reverse group) count)
              (if (null? node)
                  (values (reverse group) count)
                  (loop (ListNode-next node) (add1 count) (cons (ListNode-val node) group)))))))

  (define (helper current group-length)
    (if (null? current)
        '()
        (let-values ([(group count) (group-nodes current group-length)])
          (if (even? group-length)
              (append (reverse group) (helper (first group) (add1 group-length)))
              (append group (helper (first group) (add1 group-length)))))))

  (helper head 1))

(define (create-list lst)
  (if (null? lst)
      #f
      (let loop ((xs lst) (head (ListNode (first xs) #f)))
        (if (null? (rest xs))
            head
            (begin
              (set! (ListNode-next head) (ListNode (second xs) #f))
              (loop (rest xs) (ListNode-next head)))))))

(define example-list (create-list '(1 2 3 4 5 6 7 8 9 10 11)))
(reverse-nodes-in-even-length-groups example-list)