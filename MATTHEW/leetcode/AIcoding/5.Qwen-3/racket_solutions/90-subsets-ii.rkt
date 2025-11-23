(define (subsets-with-duplicates nums)
  (define (backtrack start path)
    (cons path
          (for/fold ([result '()])
                    ([i (in-range start (length nums))])
            (if (and (> i start) (= (list-ref nums i) (list-ref nums (sub1 i))))
                result
                (append result (backtrack (+ i 1) (cons (list-ref nums i) path)))))))
  (sort (backtrack 0 '()) (lambda (a b) (< (length a) (length b)))))