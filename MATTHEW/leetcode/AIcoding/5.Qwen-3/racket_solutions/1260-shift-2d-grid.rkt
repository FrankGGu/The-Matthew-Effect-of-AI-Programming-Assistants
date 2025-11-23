(define (shift-2d-grid grid k)
  (define rows (length grid))
  (define cols (if (> rows 0) (length (car grid)) 0))
  (define total (if (> rows 0) (* rows cols) 0))
  (define k (modulo k total))
  (if (= total 0)
      grid
      (let* ([flat (apply append grid)]
             [shifted (append (take-right flat k) (take flat (- total k)))]
             [result (map (lambda (i) (take (drop shifted (* i cols)) cols)) (range rows))])
        result)))