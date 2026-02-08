(define (count-subarrays-with-and k nums)
  (let loop ([i 0] [count 0])
    (if (>= i (length nums))
        count
        (let loop2 ([j i] [current-and (list-ref nums i)])
          (if (>= j (length nums))
              count
              (let ([next-count (if (= current-and k) (+ count 1) count)])
                (if (= j (- (length nums) 1))
                    next-count
                    (let ([new-and (bitwise-and current-and (list-ref nums (+ j 1)))])
                      (loop2 (+ j 1) new-and))))))))

(define (bitwise-and x y)
  (let loop ([i 0] [result 0])
    (if (>= i 32)
        result
        (let ([mask (arithmetic-shift 1 i)])
          (if (and (not (= 0 (bitwise-and x mask))) (not (= 0 (bitwise-and y mask))))
              (loop (+ i 1) (+ result mask))
              (loop (+ i 1) result))))))

(define (number-of-subarrays-with-and-value-k nums k)
  (count-subarrays-with-and k nums))