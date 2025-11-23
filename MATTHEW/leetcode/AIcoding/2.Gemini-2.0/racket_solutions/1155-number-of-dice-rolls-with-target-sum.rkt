(define (num-rolls-to-target n k target)
  (define memo (make-hash))
  (define (solve n target)
    (cond
      ((= n 0) (if (= target 0) 1 0))
      ((< target 0) 0)
      (else
       (hash-ref! memo (cons n target)
                  (lambda ()
                    (let loop ((i 1) (acc 0))
                      (if (> i k)
                          acc
                          (loop (+ i 1) (+ acc (solve (- n 1) (- target i)))))))))))
  (solve n target))