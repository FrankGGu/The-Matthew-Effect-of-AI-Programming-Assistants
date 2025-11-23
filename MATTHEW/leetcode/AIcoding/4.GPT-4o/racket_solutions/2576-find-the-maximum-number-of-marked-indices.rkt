(define (maxMarkedIndices nums)
  (define n (length nums))
  (define sorted-nums (sort nums <))
  (define marked (make-vector n #f))
  (define count 0)

  (for ([i (in-range n)])
    (if (not (vector-ref marked i))
        (begin
          (set! count (+ count 2))
          (set! (vector-ref marked i) #t)
          (for ([j (in-range i (+ i 1 n))])
            (when (and (not (vector-ref marked j))
                       (>= (vector-ref sorted-nums j) (* 2 (vector-ref sorted-nums i))))
              (set! (vector-ref marked j) #t))))))

  count)

(maxMarkedIndices '(1 3 3 3 5 5 5 7))