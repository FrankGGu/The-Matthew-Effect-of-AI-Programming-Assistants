(define (add-operators num target)
  (define (dfs idx path value prev)
    (cond
      [(= idx (string-length num))
       (if (= value target)
           (list path)
           '())]
      [else
       (define results '())
       (for ([i (range (+ idx 1) (string-length num) 1)])
         (define n (substring num idx i))
         (define n-value (string->number n))
         (when (and (not (string=? n "0")) (not (string=? n n))) ; Skip leading zeros
           (set! results
                 (append results
                         (dfs i (if (string=? path "") n (string-append path "+" n))
                             (+ value n-value) n-value))
                         (dfs i (if (string=? path "") n (string-append path "-" n))
                             (- value n-value) (- n-value))
                         (dfs i (if (string=? path "") n (string-append path "*" n))
                             (+ value (- (* prev n-value) prev)) (* prev n-value))))))
       results)]))

  (dfs 0 "" 0 0))

(define (expression-add-operators num target)
  (add-operators num target))