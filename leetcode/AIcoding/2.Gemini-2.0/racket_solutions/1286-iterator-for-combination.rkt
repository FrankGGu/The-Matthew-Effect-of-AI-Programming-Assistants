(define/contract (make-combination-iterator characters combinationLength)
  (-> string? exact-positive-integer? (listof string?))
  (let* ([chars (string->list characters)]
         [n (length chars)]
         [k combinationLength]
         [indices (build-list k identity)]
         [done? #f])
    (define (next)
      (if done?
          ""
          (let* ([res (list->string (map (lambda (i) (list-ref chars i)) indices))]
                 [i (sub1 k)])
            (let loop ([i i])
              (cond
                [(= i -1)
                 (set! done? #t)]
                [(= (list-ref indices i) (+ (sub1 n) (- i k)))
                 (loop (sub1 i))]
                [else
                 (set! indices (list-set indices i (+ 1 (list-ref indices i))))
                 (for ([j (in-range (add1 i) k)])
                   (set! indices (list-set indices j (+ 1 (list-ref indices (sub1 j))))))]))
            res))))
    (define (hasNext)
      (not done?))
    (list next hasNext)))