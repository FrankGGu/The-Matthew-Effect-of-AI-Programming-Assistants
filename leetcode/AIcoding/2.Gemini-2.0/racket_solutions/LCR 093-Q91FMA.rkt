(define (lenLongestFibSubseq arr)
  (let* ([s (list->set arr)]
         [n (length arr)])
    (let loop ([i 0] [max-len 0])
      (if (= i n)
          max-len
          (let loop2 ([j (+ i 1)] [max-len2 max-len])
            (if (= j n)
                (loop (+ i 1) max-len2)
                (let loop3 ([a (list-ref arr i)]
                            [b (list-ref arr j)]
                            [len 2])
                  (let ([c (+ a b)])
                    (if (set-member? s c)
                        (loop3 b c (+ len 1))
                        (loop2 (+ j 1) (max max-len2 len)))))
                )))))
  )