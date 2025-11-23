(define/contract (sort-even-odd nums)
  (-> (listof exact-integer?) (listof exact-integer?))
  (let* ([even-indices (filter (lambda (x) (even? (car x))) (map cons (range (length nums)) nums))]
         [odd-indices (filter (lambda (x) (odd? (car x))) (map cons (range (length nums)) nums))]
         [sorted-even (map cdr (sort even-indices (lambda (x y) (< (cdr x) (cdr y)))))]
         [sorted-odd (map cdr (sort odd-indices (lambda (x y) (> (cdr x) (cdr y)))))])
    (let loop ([i 0] [even sorted-even] [odd sorted-odd] [result '()])
      (if (>= i (length nums))
          (reverse result)
          (if (even? i)
              (loop (+ i 1) (cdr even) odd (cons (car even) result))
              (loop (+ i 1) even (cdr odd) (cons (car odd) result))))))