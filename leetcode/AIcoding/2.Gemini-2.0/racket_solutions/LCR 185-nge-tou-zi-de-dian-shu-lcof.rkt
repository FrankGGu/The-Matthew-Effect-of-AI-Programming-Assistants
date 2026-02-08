(define (num-roll-to-target n k target)
  (define memo (make-hash))
  (define (helper n target)
    (cond
      ((= n 0) (if (= target 0) 1 0))
      ((< target 0) 0)
      (else
       (hash-ref memo (cons n target)
                 (lambda ()
                   (let loop ((i 1) (sum 0))
                     (if (> i k)
                         sum
                         (loop (+ i 1) (+ sum (helper (- n 1) (- target i)))))))))))
  (define result (helper n target))
  (modulo result 1000000007))