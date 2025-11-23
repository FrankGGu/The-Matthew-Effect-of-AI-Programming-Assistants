#lang racket

(define (minimum-cost-to-make-all-characters-equal s)
  (let* ((n (string-length s))
         (s-int (map (lambda (c) (if (char=? c #\0) 0 1)) (string->list s))))
    (if (= n 0)
        0
        (let-values (((cost-to-0 cost-to-1)
                      (for/fold ((acc-cost-0 0) (acc-cost-1 0))
                                ((i (in-range n)))
                        (let ((char-at-i (list-ref s-int i)))
                          (if (= i (- n 1)) ; Last character
                              (values (+ acc-cost-0 (* (bitwise-xor char-at-i 0) (add1 i)))
                                      (+ acc-cost-1 (* (bitwise-xor char-at-i 1) (add1 i))))
                              (let ((char-at-i+1 (list-ref s-int (add1 i))))
                                (let ((diff (bitwise-xor char-at-i char-at-i+1)))
                                  (values (+ acc-cost-0 (* diff (add1 i)))
                                          (+ acc-cost-1 (* diff (add1 i)))))))))))
          (min cost-to-0 cost-to-1)))))