(define/contract (can-be_placed artifacts time)
  (-> (listof (listof exact-integer?)) (listof exact-integer?) boolean?)
  (let* ([n (length artifacts)]
         [start (car time)]
         [end (cadr time)]
         [count 0])
    (for ([artifact artifacts])
      (let ([s (car artifact)]
            [e (cadr artifact)])
        (when (and (>= s start) (<= e end))
          (set! count (+ count 1))))
    (>= count n))))