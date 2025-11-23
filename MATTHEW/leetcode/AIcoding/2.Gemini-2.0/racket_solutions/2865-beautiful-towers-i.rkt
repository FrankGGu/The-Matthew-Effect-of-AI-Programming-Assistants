(define (maximum-sum-of-heights heights)
  (let* ([n (length heights)]
         [max-sum (make-vector n 0)])
    (for ([i (in-range n)])
      (let loop ([j i]
                 [cur-height (vector-ref heights i)]
                 [cur-sum cur-height])
        (vector-set! max-sum i (max (vector-ref max-sum i) cur-sum))
        (when (> j 0)
          (let ([next-height (min cur-height (vector-ref heights (- j 1)))])
            (loop (- j 1) next-height (+ cur-sum next-height))))))
    (for ([i (in-range n)])
      (let loop ([j (+ i 1)]
                 [cur-height (vector-ref heights i)]
                 [cur-sum (vector-ref max-sum i)])
        (when (< j n)
          (let ([next-height (min cur-height (vector-ref heights j))])
            (vector-set! max-sum i (max (vector-ref max-sum i) (+ cur-sum next-height)))
            (loop (+ j 1) next-height (+ cur-sum next-height))))))
    (vector-max max-sum)))

(define (vector-max v)
  (let ([len (vector-length v)])
    (if (= len 0)
        0
        (let loop ([i 1]
                   [max-val (vector-ref v 0)])
          (if (= i len)
              max-val
              (let ([cur-val (vector-ref v i)])
                (loop (+ i 1) (max max-val cur-val))))))))