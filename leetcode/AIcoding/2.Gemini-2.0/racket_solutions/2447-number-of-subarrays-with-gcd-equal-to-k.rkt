(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (count-subarrays-with-gcd-k nums k)
  (let ((n (length nums)))
    (let loop ((i 0) (count 0))
      (if (= i n)
          count
          (let inner-loop ((j i) (current-gcd (list-ref nums i)))
            (cond
              ((> j (- n 1))
               (if (= current-gcd k)
                   (loop (+ i 1) (+ count 1))
                   (loop (+ i 1) count)))
              (else
               (let ((new-gcd (gcd current-gcd (list-ref nums (+ j 1)))))
                 (cond
                   ((= new-gcd k)
                    (inner-loop (+ j 1) new-gcd (+ count 1)))
                   ((> new-gcd k)
                    (inner-loop (+ j 1) new-gcd count))
                   (else
                    (inner-loop (+ j 1) new-gcd count)))))))))))