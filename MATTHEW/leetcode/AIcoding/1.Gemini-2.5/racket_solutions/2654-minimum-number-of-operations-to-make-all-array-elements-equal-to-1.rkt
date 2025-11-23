(define (min-operations nums)
  (let* ([n (length nums)]
         [ones-count (count (lambda (x) (= x 1)) nums)])

    (when (= n 1)
      (if (= (car nums) 1) 0 -1))

    (if (> ones-count 0)
        (- n ones-count)
        ;; No 1s in the array, need to create one
        (let ([min-ops-to-get-one n]) ; Initialize with a value larger than any possible j-i (max j-i is n-1)
          (for ([i (in-range n)])
            (let loop ([j (+ i 1)]
                       [current-gcd (list-ref nums i)])
              (when (< j n)
                (let ([next-gcd (gcd current-gcd (list-ref nums j))])
                  (if (= next-gcd 1)
                      (set! min-ops-to-get-one (min min-ops-to-get-one (- j i)))
                      ;; If next-gcd is not 1, continue with the updated gcd
                      (loop (+ j 1) next-gcd))))))

          (if (= min-ops-to-get-one n) ; If min-ops-to-get-one is still n, it means no subarray with gcd 1 was found
              -1
              ;; Total operations = (ops to get a 1) + (ops to propagate the 1 to n-1 other elements)
              (+ min-ops-to-get-one (- n 1)))))))