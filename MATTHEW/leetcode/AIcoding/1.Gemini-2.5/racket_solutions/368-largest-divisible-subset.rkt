(define (largest-divisible-subset nums)
  (let* ([n (length nums)]
         [sorted-nums (sort nums <)])

    (let* ([dp (make-vector n 1)]
           [parent (make-vector n -1)]
           [max-len 0]
           [max-idx -1])

      (for ([i (in-range n)])
        (for ([j (in-range i)])
          (when (zero? (remainder (vector-ref sorted-nums i) (vector-ref sorted-nums j)))
            (when (> (+ 1 (vector-ref dp j)) (vector-ref dp i))
              (vector-set! dp i (+ 1 (vector-ref dp j)))
              (vector-set! parent i j)))))

      (for ([i (in-range n)])
        (when (> (vector-ref dp i) max-len)
          (set! max-len (vector-ref dp i))
          (set! max-idx i)))

      (let loop ([current-idx max-idx]
                 [result '()])
        (if (= current-idx -1)
            result
            (loop (vector-ref parent current-idx)
                  (cons (vector-ref sorted-nums current-idx) result)))))))