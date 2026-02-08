(define/contract (unmarked-sum-array nums queries)
  (-> (listof exact-integer?) (listof (listof exact-integer?)) (listof exact-integer?))
  (let* ([n (length nums)]
         [marked (make-hash)]
         [sum (apply + nums)]
         [result '()])
    (for ([query queries])
      (let* ([index (first query)]
             [k (second query)]
             [current (list-ref nums index)])
      (unless (hash-has-key? marked index)
        (hash-set! marked index #t)
        (set! sum (- sum (list-ref nums index))))
      (let ([count 0]
            [i 0])
        (while (and (< i n) (< count k))
          (unless (hash-has-key? marked i)
            (hash-set! marked i #t)
            (set! sum (- sum (list-ref nums i)))
            (set! count (+ count 1)))
          (set! i (+ i 1))))
      (set! result (cons sum result)))
    (reverse result)))