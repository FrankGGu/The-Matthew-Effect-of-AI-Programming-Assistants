(define (smallest-value n)
  (let loop ((n n) (seen (hash)))
    (if (hash-has-key? seen n)
        n
        (let ((sum (prime-factor-sum n)))
          (if (= sum n)
              n
              (begin
                (hash-set! seen n #t)
                (loop sum seen)))))))

(define (prime-factor-sum n)
  (let loop ((n n) (sum 0) (i 2))
    (cond
      ((= n 1) sum)
      ((<= (* i i) n)
       (if (= (remainder n i) 0)
           (loop (/ n i) (+ sum i) i)
           (loop n sum (+ i 1))))
      (else (+ sum n)))))