#lang racket

(struct Solution (prefix-sums total-weight))

(define (Solution-constructor weights)
  (let-values (((sums total)
                (for/fold ((acc-sums '()) (current-sum 0))
                          ((w weights))
                  (let ((new-sum (+ current-sum w)))
                    (values (cons new-sum acc-sums) new-sum)))))
    (Solution (reverse sums) total)))

(define (Solution-pick-index self)
  (let* ((prefix-sums (Solution-prefix-sums self))
         (total-weight (Solution-total-weight self))
         (target (+ 1 (random total-weight))))

    (let loop ((low 0)
               (high (sub1 (length prefix-sums))))
      (if (<= low high)
          (let* ((mid (quotient (+ low high) 2))
                 (mid-val (list-ref prefix-sums mid)))
            (if (< mid-val target)
                (loop (+ mid 1) high)
                (loop low (sub1 mid))))
          low))))