(define (distinctAverages A)
  (define averages (map (lambda (x) (/ (+ (car x) (cadr x)) 2.0))
                         (sort (map (lambda (x) (list x)) A) <)))
  (define distinct-averages (remove-duplicates averages))
  (length distinct-averages))

(define (number-of-distinct-averages A)
  (distinctAverages A))