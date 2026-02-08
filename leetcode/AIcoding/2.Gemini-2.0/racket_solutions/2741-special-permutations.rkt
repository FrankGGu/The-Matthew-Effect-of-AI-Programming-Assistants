(define (special-permutations nums)
  (define n (length nums))
  (define memo (make-hash))

  (define (helper mask prev)
    (if (= mask (expt 2 n) -1)
        1
        (hash-ref! memo (list mask prev)
                   (lambda ()
                     (let loop ((i 0) (count 0))
                       (if (= i n)
                           count
                           (if (and (zero? (bitwise-and mask (expt 2 i)))
                                    (or (equal? prev -1)
                                        (or (zero? (modulo (list-ref nums i) (list-ref nums prev)))
                                            (zero? (modulo (list-ref nums prev) (list-ref nums i))))))
                               (loop (+ i 1) (+ count (helper (bitwise-ior mask (expt 2 i)) i))))
                           (loop (+ i 1) count))))))))

  (modulo (helper 0 -1) 1000000007))