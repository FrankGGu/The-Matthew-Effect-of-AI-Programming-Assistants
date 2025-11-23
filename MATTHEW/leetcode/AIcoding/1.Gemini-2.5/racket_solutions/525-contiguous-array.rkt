(require racket/hash)

(define (find-max-length nums)
  (let* ([n (vector-length nums)]
         [sum-to-index (make-hash)]
         [max-len 0]
         [current-sum 0])

    (hash-set! sum-to-index 0 -1)

    (for ([i (in-range n)])
      (let ([num (vector-ref nums i)])
        (set! current-sum (+ current-sum (if (= num 0) -1 1)))

        (cond
          [(hash-has-key? sum-to-index current-sum)
           (set! max-len (max max-len (- i (hash-ref sum-to-index current-sum))))]
          [else
           (hash-set! sum-to-index current-sum i)])))
    max-len))