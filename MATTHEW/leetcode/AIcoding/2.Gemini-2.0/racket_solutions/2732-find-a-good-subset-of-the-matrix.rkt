(define (good-subset matrix)
  (define m (length matrix))
  (define n (length (first matrix)))

  (define (check-subset subset)
    (let loop ([j 0])
      (cond
        [(>= j n) #t]
        [else
         (let ([sum 0])
           (for ([i subset])
             (set! sum (+ sum (list-ref (list-ref matrix i) j))))
           (if (= sum 0)
               #t
               (loop (+ j 1))))]))
    )

  (let loop ([i 1] [subset '()])
    (cond
      [(>= i (expt 2 m)) #f]
      [else
       (let ([current-subset '()])
         (for/list ([j (in-range m)])
           (when (positive? (bitwise-and i (expt 2 j)))
             (set! current-subset (cons j current-subset))))
         (if (and (not (null? current-subset)) (check-subset current-subset))
             current-subset
             (loop (+ i 1) '())))])))