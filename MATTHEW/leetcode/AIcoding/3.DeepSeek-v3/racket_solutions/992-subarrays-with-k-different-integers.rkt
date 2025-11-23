(define/contract (subarrays-with-k-distinct nums k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (define (at-most-k k)
    (let loop ([left 0] [right 0] [count 0] [freq (make-hash)] [res 0])
      (if (>= right (length nums))
          res
          (let* ([num (list-ref nums right)]
                 [freq-val (hash-ref freq num 0)])
            (hash-set! freq num (add1 freq-val))
            (let ([count (if (= freq-val 0) (add1 count) count)])
              (while (> count k)
                (let* ([left-num (list-ref nums left)]
                       [left-freq (sub1 (hash-ref freq left-num))])
                  (hash-set! freq left-num left-freq)
                  (when (= left-freq 0)
                    (set! count (sub1 count)))
                  (set! left (add1 left))))
              (loop left (add1 right) count freq (+ res (- right left 1))))))))
  (- (at-most-k k) (at-most-k (- k 1))))