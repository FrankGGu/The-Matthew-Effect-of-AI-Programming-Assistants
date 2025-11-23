(define (max-subarrays nums)
  (define (solve nums)
    (define (helper nums start end)
      (if (>= start end)
          0
          (let ([current-gcd (foldl gcd (first nums) (subvector nums start end))])
            (if (= current-gcd 1)
                1
                0))))

    (define (count-subarrays nums)
      (let loop ([start 0] [count 0])
        (if (>= start (length nums))
            count
            (let loop2 ([end (+ start 1)])
              (cond
                [(>= end (length nums))
                 (loop (+ start 1) count)]
                [(= (helper nums start end) 1)
                 (loop end (+ count 1))]
                [else
                 (loop2 (+ end 1))])))))

    (define (remove-and-count nums i j)
      (let ([new-nums (append (subvector nums 0 i) (subvector nums (+ i 1) j) (subvector nums (+ j 1) (length nums)))])
        (count-subarrays new-nums)))

    (define (find-conflicting-pairs nums)
      (let loop ([i 0] [pairs '()])
        (cond
          [(>= i (length nums)) pairs]
          [else
           (let loop2 ([j (+ i 1)])
             (cond
               [(>= j (length nums)) (loop (+ i 1) pairs)]
               [(= (gcd (list-ref nums i) (list-ref nums j)) 1) (loop2 (+ j 1))]
               [else (loop (+ i 1) (cons (list i j) pairs))]))])))

    (let ([conflicts (find-conflicting-pairs nums)])
      (if (null? conflicts)
          (count-subarrays nums)
          (apply max (map (lambda (pair) (remove-and-count nums (first pair) (second pair))) conflicts)))))

  (solve nums))