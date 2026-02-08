(define (sum-of-array-product-of-magical-sequences nums)
  (define n (length nums))
  (define MOD 1000000007)

  (define (magical-sequence left right)
    (cond
      [(< left right)
       (define min-index (argmin (λ (i) (list-ref nums i)) (range left (+ right 1))))
       (let* ([min-val (list-ref nums min-index)]
              [left-sum (magical-sequence left (- min-index 1))]
              [right-sum (magical-sequence (+ min-index 1) right)])
         (modulo (+ (* min-val (+ left-sum right-sum 1)) left-sum right-sum) MOD))]
      [(= left right) 1]
      [else 0]))

  (magical-sequence 0 (- n 1)))

(define (argmin f lst)
  (define (argmin-helper lst current-min current-min-index index)
    (cond
      [(empty? lst) current-min-index]
      [else
       (let ([val (f (car lst))])
         (if (< val current-min)
             (argmin-helper (cdr lst) val index (+ index 1))
             (argmin-helper (cdr lst) current-min current-min-index (+ index 1))))]))
  (argmin-helper lst (f (car lst)) 0 1))