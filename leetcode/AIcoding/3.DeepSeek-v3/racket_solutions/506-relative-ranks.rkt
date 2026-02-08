(define/contract (find-relative-ranks score)
  (-> (listof exact-integer?) (listof string?))
  (let* ([indexed (map cons score (range (length score))]
         [sorted (sort indexed > #:key car)]
         [ranks (make-hash)]
         [n (length score)])
    (for ([i (in-range n)])
      (hash-set! ranks (cdr (list-ref sorted i))
                  (cond
                    [(= i 0) "Gold Medal"]
                    [(= i 1) "Silver Medal"]
                    [(= i 2) "Bronze Medal"]
                    [else (number->string (+ i 1))])))
    (for/list ([i (in-range n)])
      (hash-ref ranks i))))