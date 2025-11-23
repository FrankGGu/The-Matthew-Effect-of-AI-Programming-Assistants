(define (count-excellent-pairs nums k)
  (let* ([counts (make-hash)]
         [_ (for ([num (in-list nums)])
             (hash-update! counts num (λ (v) (+ v 1)) 1))]
         [distinct-nums (hash-keys counts)]
         [n (length distinct-nums)]
         [bits (λ (x)
                 (let loop ([n x] [count 0])
                   (if (= n 0)
                       count
                       (loop (bitwise-and n (- n 1)) (+ count 1)))))]
         [bit-counts (map bits distinct-nums)])
    (let loop ([i 0] [total 0])
      (if (= i n)
          total
          (let* ([count-i (hash-ref counts (list-ref distinct-nums i))]
                 [bit-count-i (list-ref bit-counts i)]
                 [valid-j-count
                  (foldl + 0
                         (map (λ (bit-count-j count-j)
                                (if (>= (+ bit-count-i bit-count-j) k)
                                    count-j
                                    0))
                              bit-counts
                              (map (λ (num) (hash-ref counts num)) distinct-nums)))])
            (loop (+ i 1) (+ total (* count-i valid-j-count))))))))