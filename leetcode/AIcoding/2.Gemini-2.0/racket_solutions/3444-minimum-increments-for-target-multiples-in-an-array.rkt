(define (min-increments target nums)
  (define (gcd a b)
    (if (= b 0)
        a
        (gcd b (remainder a b))))

  (define (lcm a b)
    (/ (* a b) (gcd a b)))

  (define (solve target nums)
    (let loop ((i 0) (lcm-val 1) (count 0))
      (if (= i (length nums))
          (cond
            [(= lcm-val target) count]
            [(< lcm-val target) (+ count (- target lcm-val))]
            [else #f])
          (let* ((num (list-ref nums i))
                 (new-lcm (lcm lcm-val num)))
            (cond
              [(> new-lcm target)
               (loop (+ i 1) lcm-val (+ count (- target lcm-val)))]
              [else
               (loop (+ i 1) new-lcm count)])))))

  (solve target nums))