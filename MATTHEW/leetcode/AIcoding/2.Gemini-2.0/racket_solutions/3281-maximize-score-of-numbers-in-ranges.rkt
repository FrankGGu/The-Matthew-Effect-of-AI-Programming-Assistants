(define (maximumScore ranges nums)
  (define n (length nums))
  (define m (length ranges))
  (define diff (make-vector (add1 n) 0))

  (for ([range ranges])
    (define start (first range))
    (define end (second range))
    (define incr (third range))
    (vector-set! diff start (+ (vector-ref diff start) incr))
    (when (< (add1 end) n)
      (vector-set! diff (add1 end) (- (vector-ref diff (add1 end)) incr))))

  (define prefix-sum (make-vector n 0))
  (vector-set! prefix-sum 0 (vector-ref diff 0))
  (for ([i (in-range 1 n)])
    (vector-set! prefix-sum i (+ (vector-ref prefix-sum (sub1 i)) (vector-ref diff i))))

  (define sorted-nums (sort nums >))
  (define sorted-prefix-sum (sort (vector->list prefix-sum) >))

  (define ans 0)
  (for ([i (in-range n)])
    (set! ans (+ ans (* (list-ref sorted-nums i) (list-ref sorted-prefix-sum i)))))

  ans)