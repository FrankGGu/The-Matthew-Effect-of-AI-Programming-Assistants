(define (num-subarrays-with-odd-sum nums)
  (define mod 1000000007)
  (define (helper nums even odd)
    (cond
      [(empty? nums) (modulo odd mod)]
      [else (let* ([first (first nums)]
                    [rest (rest nums)])
               (if (odd? first)
                   (helper rest (+ even 1) odd)
                   (helper rest even (+ odd 1))))]))
  (helper nums 0 0))

(define (num-subarrays-with-odd-sum-iter nums)
  (define mod 1000000007)
  (let loop ([nums nums] [even 0] [odd 0] [result 0])
    (if (empty? nums)
        (modulo result mod)
        (let ([first (first nums)]
              [rest (rest nums)])
          (if (odd? first)
              (loop rest (+ even 1) odd (+ result even))
              (loop rest even (+ odd 1) (+ result odd)))))))

(define (num-subarrays-with-odd-sum-dp nums)
  (define mod 1000000007)
  (let loop ([nums nums] [even 0] [odd 0] [result 0])
    (if (empty? nums)
        (modulo result mod)
        (let ([first (first nums)])
          (if (odd? first)
              (loop (cdr nums) (+ even 1) odd (+ result even))
              (loop (cdr nums) even (+ odd 1) (+ result odd)))))))

(define (num-subarrays-with-odd-sum-final nums)
  (define mod 1000000007)
  (let loop ([nums nums] [even 0] [odd 0] [result 0])
    (cond
      [(empty? nums) (modulo result mod)]
      [else
       (let ([first (first nums)])
         (if (odd? first)
             (loop (rest nums) (+ even 1) odd (modulo (+ result even) mod))
             (loop (rest nums) even (+ odd 1) (modulo (+ result odd) mod))))])))