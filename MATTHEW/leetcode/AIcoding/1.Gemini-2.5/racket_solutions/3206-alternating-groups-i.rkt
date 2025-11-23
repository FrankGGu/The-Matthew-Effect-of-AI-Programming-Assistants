(define (alternating-groups colors k)
  (let* ([n (length colors)]
         [colors-vec (list->vector colors)]
         [count 0])
    (for ([i (in-range n)])
      (let ([is-alternating? #t])
        (for ([j (in-range (- k 1))])
          (let ([c1 (vector-ref colors-vec (modulo (+ i j) n))]
                [c2 (vector-ref colors-vec (modulo (+ i j 1) n))])
            (when (= c1 c2)
              (set! is-alternating? #f)
              (break))))
        (when is-alternating?
          (set! count (+ count 1)))))
    count))