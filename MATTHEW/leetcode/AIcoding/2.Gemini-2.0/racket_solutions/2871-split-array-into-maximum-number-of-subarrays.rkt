(define (max-subarrays split-num)
  (let loop ([nums split-num] [res 0] [curr (car nums)])
    (cond
      [(null? nums) res]
      [else
       (let ([new-curr (bitwise-and curr (car nums))])
         (if (= new-curr 0)
             (loop (cdr nums) (+ res 1) (car nums))
             (loop (cdr nums) res new-curr)))])))

(define (split-array nums)
  (let ([first-num (car nums)])
    (if (= first-num 0)
        (length nums)
        (let loop ([rest-nums (cdr nums)] [curr first-num])
          (cond
            [(null? rest-nums) 1]
            [else
             (let ([new-curr (bitwise-and curr (car rest-nums))])
               (if (= new-curr 0)
                   (+ 1 (split-array (cdr rest-nums)))
                   (loop (cdr rest-nums) new-curr)))])))))