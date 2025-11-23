(define (find-middle-index nums)
  (define total-sum (apply + nums))
  (define (helper index left-sum)
    (cond
      [(equal? index (length nums)) -1]
      [(equal? left-sum (- total-sum left-sum (list-ref nums index))) index]
      [else (helper (+ index 1) (+ left-sum (list-ref nums index)))]))
  (helper 0 0))