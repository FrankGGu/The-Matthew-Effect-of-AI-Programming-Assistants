(define (remove-covered-intervals intervals)
  (define sorted-intervals (sort intervals (lambda (a b) (or (< (car a) (car b)) (and (= (car a) (car b)) (< (cadr a) (cadr b)))))))
  (define count 0)
  (define max-end 0)
  (for-each (lambda (interval)
              (if (> (cadr interval) max-end)
                  (begin
                    (set! count (+ count 1))
                    (set! max-end (cadr interval)))))
            sorted-intervals)
  count)

(remove-covered-intervals '((1 4) (3 6) (2 8))) ; should return 2