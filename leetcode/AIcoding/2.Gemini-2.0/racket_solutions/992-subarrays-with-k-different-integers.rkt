(define (subarrays-with-k-different-integers nums k)
  (define (at-most-k-distinct nums k)
    (define (count-subarrays start end distinct-count freq)
      (cond
        [(> end (length nums)) 0]
        [else
         (let* ([num (list-ref nums end)]
                [new-freq (hash-ref freq num 0)]
                [new-distinct-count (if (= new-freq 0) (+ distinct-count 1) distinct-count)])
           (if (> new-distinct-count k)
               (count-subarrays (+ start 1) (+ start 1) 0 (make-hash))
               (+ (- end start) 1 (count-subarrays start (+ end 1) new-distinct-count (hash-update freq num (+ new-freq 1))))))]))
    (count-subarrays 0 0 0 (make-hash)))

  (- (at-most-k-distinct nums k) (at-most-k-distinct nums (- k 1))))