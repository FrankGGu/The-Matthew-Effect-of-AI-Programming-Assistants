(define (findLongestChain pairs)
  (define sorted-pairs (sort pairs (lambda (a b) (< (cdr a) (cdr b)))))
  (define (helper current-end remaining-pairs)
    (cond
      [(empty? remaining-pairs) 0]
      [else
       (let ([first-pair (car remaining-pairs)]
             [rest-pairs (cdr remaining-pairs)])
         (if (< current-end (car first-pair))
             (+ 1 (helper (cdr first-pair) rest-pairs))
             (helper current-end rest-pairs))))))
  (if (empty? sorted-pairs)
      0
      (+ 1 (helper (cdr (car sorted-pairs)) (cdr sorted-pairs)))))