(define (findNonMinOrMax nums)
  (define sorted (sort nums <))
  (if (or (< (length sorted) 3) (and (= (car sorted) (cadr sorted)) (= (cadr sorted) (last sorted))))
      -1
      (cadr (cdr sorted))))