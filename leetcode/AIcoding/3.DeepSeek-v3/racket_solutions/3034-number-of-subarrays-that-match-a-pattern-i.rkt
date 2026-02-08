(define (count-matching-subarrays nums pattern)
  (define n (length nums))
  (define m (length pattern))
  (define count 0)

  (for ([i (in-range 0 (- n m))])
    (define match #t)
    (for ([j (in-range 0 m)])
      (define num1 (list-ref nums (+ i j)))
      (define num2 (list-ref nums (+ i j 1)))
      (define pat (list-ref pattern j))
      (cond
        [(= pat 1) (when (not (> num2 num1)) (set! match #f))]
        [(= pat 0) (when (not (= num2 num1)) (set! match #f))]
        [(= pat -1) (when (not (< num2 num1)) (set! match #f))]))
    (when match (set! count (+ count 1))))

  count)