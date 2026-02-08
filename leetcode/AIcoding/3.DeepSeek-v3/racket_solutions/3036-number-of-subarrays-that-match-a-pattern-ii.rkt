(define/contract (count-matching-subarrays nums pattern)
  (-> (listof exact-integer?) (listof exact-integer?) exact-integer?)
  (define n (length nums))
  (define m (length pattern))
  (define result 0)

  (define (get-relation a b)
    (cond
      [(< a b) -1]
      [(= a b) 0]
      [else 1]))

  (for ([i (in-range 0 (- n m))])
    (define valid #t)
    (for ([j (in-range 0 m)])
      (define a (list-ref nums (+ i j)))
      (define b (list-ref nums (+ i j 1)))
      (define rel (get-relation a b))
      (define p (list-ref pattern j))
      (when (not (= rel p))
        (set! valid #f)
        (break)))
    (when valid
      (set! result (add1 result))))

  result)