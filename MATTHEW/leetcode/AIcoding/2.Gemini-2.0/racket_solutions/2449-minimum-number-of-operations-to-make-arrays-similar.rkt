(define (make-similar nums target)
  (define (filter-parity lst parity)
    (filter (lambda (x) (= (modulo x 2) parity)) lst))

  (define (count-ops nums target)
    (let* ([nums-even (sort (filter-parity nums 0) <)]
           [nums-odd (sort (filter-parity nums 1) <)]
           [target-even (sort (filter-parity target 0) <)]
           [target-odd (sort (filter-parity target 1) <)]
           [even-diffs (map - nums-even target-even)]
           [odd-diffs (map - nums-odd target-odd)]
           [pos-even (filter (lambda (x) (> x 0)) even-diffs)]
           [pos-odd (filter (lambda (x) (> x 0)) odd-diffs)])
      (/ (apply + pos-even) 2))))

  (count-ops nums target))