(define (largest-values-from-labels labels numbers target)
  (define sorted (sort (map list labels numbers) (lambda (a b) (> (second a) (second b)))))
  (define (helper lst count res)
    (if (or (null? lst) (= count target))
        res
        (let* ([label (first (car lst))]
               [value (second (car lst))])
          (if (member label res)
              (helper (cdr lst) count res)
              (helper (cdr lst) (+ count 1) (append res (list label)))))))
  (take (helper sorted 0 '()) target))