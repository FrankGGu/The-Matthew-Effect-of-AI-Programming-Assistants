(define/contract (partition-labels s)
  (-> string? (listof exact-integer?))
  (let* ([last-pos (make-hash)]
         [n (string-length s)]
         [result '()]
         [start 0]
         [end 0])
    (for ([i (in-range n)])
      (hash-set! last-pos (string-ref s i) i))
    (for ([i (in-range n)])
      (set! end (max end (hash-ref last-pos (string-ref s i))))
      (when (= i end)
        (set! result (cons (- end start -1) result))
        (set! start (+ end 1))))
    (reverse result)))