(define (countMaxOrSubsets nums)
  (define (count-sets max-or)
    (define (count-helper index current-or)
      (if (= index (length nums))
          (if (= current-or max-or) 1 0)
          (+ (count-helper (+ index 1) current-or)
             (count-helper (+ index 1) (bitwise-ior current-or (list-ref nums index))))))
    (count-helper 0 0))

  (define max-or (apply max (map (lambda (x) (bitwise-ior x x)) nums)))
  (count-sets max-or))

(countMaxOrSubsets '(1 2 3))