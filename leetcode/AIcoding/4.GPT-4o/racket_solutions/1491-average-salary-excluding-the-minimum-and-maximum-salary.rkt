(define (average-salary-salaries salaries)
  (define min-salary (apply min salaries))
  (define max-salary (apply max salaries))
  (define filtered-salaries (filter (lambda (s) (and (> s min-salary) (< s max-salary))) salaries))
  (if (null? filtered-salaries)
      0
      (/ (apply + filtered-salaries) (length filtered-salaries))))