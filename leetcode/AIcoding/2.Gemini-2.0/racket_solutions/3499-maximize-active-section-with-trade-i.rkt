(define (max-active-sections nums)
  (let* [(n (length nums))
         (prefix-sums (make-vector (+ n 1) 0))
         (max-len 0)]
    (for/list ([i (in-range n)])
      (vector-set! prefix-sums (+ i 1) (+ (vector-ref prefix-sums i) (list-ref nums i))))
    (for ([i (in-range n)])
      (for ([j (in-range (+ i 1) n)])
        (let [(len (- j i))]
          (when (and (<= 0 i) (< i n) (<= 0 j) (< j n))
            (let [(active-length (- (vector-ref prefix-sums j) (vector-ref prefix-sums i)))]
              (set! max-len (max max-len active-length)))))))
    max-len))