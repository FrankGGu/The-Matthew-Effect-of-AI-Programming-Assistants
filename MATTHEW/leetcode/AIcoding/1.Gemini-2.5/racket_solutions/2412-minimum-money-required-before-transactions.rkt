#lang racket

(define (minimum-money transactions)
  (define group-a
    (filter (lambda (t) (>= (cadr t) (car t))) transactions))

  (define group-b
    (filter (lambda (t) (< (cadr t) (car t))) transactions))

  (define sorted-group-a
    (sort group-a (lambda (t1 t2) (< (car t1) (car t2)))))

  (define sorted-group-b
    (sort group-b
          (lambda (t1 t2)
            (let* ((c1 (car t1)) (g1 (cadr t1))
                   (c2 (car t2)) (g2 (cadr t2))
                   (diff1 (- c1 g1))
                   (diff2 (- c2 g2)))
              (or (> diff1 diff2)
                  (and (= diff1 diff2) (> c1 c2)))))))

  (define all-sorted-transactions
    (append sorted-group-a sorted-group-b))

  (define-values (min-initial-money current-money-level)
    (foldl (lambda (transaction acc)
             (let* ((c (car transaction))
                    (g (cadr transaction))
                    (current-min-initial-money (car acc))
                    (current-level (cadr acc)))
               (let* ((money-needed-for-transaction c)
                      (money-to-add (max 0 (- money-needed-for-transaction current-level))))
                 (list (+ current-min-initial-money money-to-add)
                       (- (+ current-level money-to-add) c g)))))
           (list 0 0)
           all-sorted-transactions))
  min-initial-money)