(define (combination-sum-iii k n)
  (define (backtrack start path k n)
    (cond
      ((= (length path) k) (if (= (apply + path) n) (list path) '()))
      ((or (> (length path) k) (> (apply + path) n)) '())
      (else
        (apply append
               (map (lambda (x)
                      (backtrack (+ x 1) (cons x path) k n))
                    (range start 10)))))
  (backtrack 1 '() k n))

(define (range start end)
  (if (>= start end)
      '()
      (cons start (range (+ start 1) end))))

(define (combination-sum-iii-solution k n)
  (combination-sum-iii k n))