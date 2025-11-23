(define (maximum-sum-of-distinct-subarrays-with-length-k nums k)
  (let* ([n (length nums)]
         [max-sum 0]
         [curr-sum 0]
         [freq (make-hash)]
         [left 0])
    (for ([right (in-range n)])
      (let ([num (list-ref nums right)])
        (hash-update! freq num (λ (x) (+ x 1)) 1)
        (set! curr-sum (+ curr-sum num))
        (when (> (- right left) (- k 1))
          (let ([left-num (list-ref nums left)])
            (set! curr-sum (- curr-sum left-num))
            (hash-update! freq left-num (λ (x) (- x 1)) 0)
            (when (= (hash-ref freq left-num) 0)
              (hash-remove! freq left-num))
            (set! left (+ left 1))))
        (when (= (- right left) (- k 1))
          (when (= (hash-count freq) k)
            (set! max-sum (max max-sum curr-sum)))))
    max-sum))