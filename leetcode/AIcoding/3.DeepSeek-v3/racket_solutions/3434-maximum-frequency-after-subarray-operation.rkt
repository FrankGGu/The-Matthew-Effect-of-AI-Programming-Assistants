(define (max-frequency nums)
  (let loop ([i 0] [max-freq 0] [freq (make-hash)] [prev-sum 0])
    (if (>= i (length nums))
        max-freq
        (let* ([current (list-ref nums i)]
               [new-sum (+ prev-sum current)]
               [new-freq (hash-update freq new-sum add1 0)]
               [current-freq (hash-ref new-freq new-sum)]
               [new-max (max max-freq current-freq)])
          (loop (add1 i) new-max new-freq new-sum))))

(define (maxFrequencyOperations nums k)
  (let ([n (length nums)]
        [max-freq 0]
        [freq (make-hash)])
    (hash-set! freq 0 1)
    (let loop ([i 0] [sum 0] [max-freq 0])
      (if (>= i n)
          max-freq
          (let* ([current (list-ref nums i)]
                 [sum (+ sum current)]
                 [target (- sum k)]
                 [count (hash-ref freq target 0)]
                 [new-max (max max-freq (add1 count))])
            (hash-update! freq sum add1 1)
            (loop (add1 i) sum new-max))))))