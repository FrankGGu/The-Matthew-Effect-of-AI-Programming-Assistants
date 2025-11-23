(define-struct ListNode (val next))

(define (split-list-to-parts head k)
  (define (length node)
    (if (null? node)
        0
        (+ 1 (length (ListNode-next node)))))

  (define n (length head))
  (define part-size (quotient n k))
  (define remainder (modulo n k))

  (define (split-helper node size)
    (if (or (null? node) (<= size 0))
        (values node 0)
        (let-values ([(next-node remaining) (split-helper (ListNode-next node) (sub1 size))])
          (if (= remaining 0)
              (values (ListNode-next node) 0)
              (begin
                (set! (ListNode-next node) next-node)
                (values (ListNode-next node) (sub1 remaining))))))

  (define parts (make-vector k))
  (define current head)

  (for* ([i (in-range k)])
    (let-values ([(next-node remaining) (split-helper current part-size)])
      (vector-set! parts i current)
      (set! current next-node)))

  (vector->list parts))