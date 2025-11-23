(define (minimumIncompatibility nums k)
  (define (valid? subset)
    (let loop ((s subset) (seen '()))
      (cond
        ((null? s) #t)
        ((member (car s) seen) #f)
        (else (loop (cdr s) (cons (car s) seen))))))

  (define (incompatibility subset)
    (if (valid? subset)
      (apply + (map (λ (x) (apply max x))
                    (combinations (map list subset) 2)))
      +inf.0))

  (define (backtrack index groups)
    (if (= index (length nums))
      (if (= (length (filter not (map null? groups))) k)
          (apply min (map incompatibility (filter not (map null? groups))))
          +inf.0)
      (let loop ((i 0) (best +inf.0))
        (if (= i k)
          best
          (let* ((curr (list-ref nums index))
                 (updated (cons (cons curr (if (null? (list-ref groups i)) '() (list-ref groups i))) (vector->list groups))))
            (loop (add1 i) (min best (backtrack (add1 index) (list->vector updated)))))))))

  (define sorted-nums (sort nums <))
  (backtrack 0 (make-vector k '())))