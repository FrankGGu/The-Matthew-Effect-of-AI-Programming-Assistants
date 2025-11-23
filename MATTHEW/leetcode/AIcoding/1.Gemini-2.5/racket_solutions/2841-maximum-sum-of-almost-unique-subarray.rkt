(define (maximum-sum-of-almost-unique-subarray nums m k)
  (define n (length nums))
  (if (< n k)
      0
      (let ([max-sum 0]
            [current-sum 0]
            [freq-map (make-hash)]
            [distinct-count 0])
        (define (add-element! val)
          (let ([current-freq (hash-ref freq-map val 0)])
            (when (= current-freq 0)
              (set! distinct-count (add1 distinct-count)))
            (hash-set! freq-map val (add1 current-freq))
            (set! current-sum (+ current-sum val))))
        (define (remove-element! val)
          (let ([current-freq (hash-ref freq-map val)])
            (hash-set! freq-map val (sub1 current-freq))
            (when (= (sub1 current-freq) 0)
              (set! distinct-count (sub1 distinct-count)))
            (set! current-sum (- current-sum val))))

        (for ([i (in-range k)])
          (add-element! (list-ref nums i)))

        (when (>= distinct-count m)
          (set! max-sum current-sum))

        (for ([i (in-range k n)])
          (remove-element! (list-ref nums (- i k)))
          (add-element! (list-ref nums i))
          (when (>= distinct-count m)
            (set! max-sum (max max-sum current-sum))))

        max-sum)))