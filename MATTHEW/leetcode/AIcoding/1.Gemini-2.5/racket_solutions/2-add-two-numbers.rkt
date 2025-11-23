(define-struct list-node (val next))

(define (add-two-numbers l1 l2)
  (define (add-rec l1 l2 carry)
    (cond
      ((and (null? l1) (null? l2) (= carry 0))
       null)
      (else
       (let* ((val1 (if (null? l1) 0 (list-node-val l1)))
              (val2 (if (null? l2) 0 (list-node-val l2)))
              (sum (+ val1 val2 carry))
              (new-digit (remainder sum 10))
              (new-carry (quotient sum 10)))
         (list-node new-digit
                    (add-rec (if (null? l1) null (list-node-next l1))
                             (if (null? l2) null (list-node-next l2))
                             new-carry))))))
  (add-rec l1 l2 0))