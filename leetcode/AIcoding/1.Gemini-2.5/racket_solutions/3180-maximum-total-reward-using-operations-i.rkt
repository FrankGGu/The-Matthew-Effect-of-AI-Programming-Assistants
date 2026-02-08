(require srfi/1)

(define (maximum-total-reward rewards)
  (let* ([sorted-rewards (list-sort < rewards)])
    (foldl (lambda (r current-total)
             (if (> r current-total)
                 (+ current-total r)
                 current-total))
           0
           sorted-rewards)))