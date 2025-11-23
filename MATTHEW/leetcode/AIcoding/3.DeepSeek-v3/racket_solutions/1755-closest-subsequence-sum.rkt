(define/contract (min-abs-difference nums goal)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (define n (length nums))
  (define half (quotient n 2))
  (define left (take nums half))
  (define right (drop nums half))

  (define (generate-sums nums)
    (define sums (mutable-set 0))
    (for ([num nums])
      (define new-sums (mutable-set))
      (for ([s sums])
        (set-add! new-sums (+ s num)))
      (set-union! sums new-sums))
    (sort (set->list sums) <))

  (define left-sums (generate-sums left))
  (define right-sums (generate-sums right))

  (define min-diff +inf.0)

  (for ([s left-sums])
    (define target (- goal s))
    (define idx (binary-search right-sums target))
    (when (< idx (length right-sums))
      (set! min-diff (min min-diff (abs (- (+ s (list-ref right-sums idx)) goal)))))
    (when (> idx 0)
      (set! min-diff (min min-diff (abs (- (+ s (list-ref right-sums (- idx 1))) goal))))))

  (inexact->exact (round min-diff)))

(define (binary-search lst target)
  (let loop ([low 0]
             [high (- (length lst) 1)])
    (if (> low high)
        low
        (let* ([mid (quotient (+ low high) 2)]
               [mid-val (list-ref lst mid)])
          (cond
            [(= mid-val target) mid]
            [(< mid-val target) (loop (+ mid 1) high)]
            [else (loop low (- mid 1))])))))