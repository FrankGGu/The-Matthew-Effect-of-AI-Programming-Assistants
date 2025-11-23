(define/contract (min-taps n ranges)
  (-> exact-integer? (listof exact-integer?) exact-integer?)
  (let* ([intervals (for/list ([i (in-range (add1 n))])
                      (list (max 0 (- i (list-ref ranges i)))
                            (min n (+ i (list-ref ranges i)))))])
    (let loop ([start 0] [end 0] [taps 0] [i 0])
      (cond
        [(>= start n) taps]
        [(> (list-ref (list-ref intervals i) 0) start) -1]
        [else
         (let ([new-end (max end (list-ref (list-ref intervals i) 1))])
           (if (= i (length intervals))
               (if (>= new-end n) (add1 taps) -1)
               (if (and (< i (length intervals)) (> new-end start))
                   (loop start new-end taps (add1 i))
                   (if (>= new-end n)
                       (add1 taps)
                       (if (= end new-end)
                           -1
                           (loop new-end new-end (add1 taps) 0))))))]))))