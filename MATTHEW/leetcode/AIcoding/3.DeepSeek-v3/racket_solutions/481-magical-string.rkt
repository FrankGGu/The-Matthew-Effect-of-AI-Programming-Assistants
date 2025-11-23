(define (magical-string n)
  (if (zero? n) 0
      (let loop ([s (list 1 2 2)]
                 [i 2]
                 [count 1])
        (if (>= (length s) n)
            count
            (let* ([next-num (if (odd? (length s)) 1 2)]
                   [next-count (list-ref s i)]
                   [new-s (append s (make-list next-count next-num))])
              (loop new-s
                    (+ i 1)
                    (if (equal? next-num 1)
                        (+ count next-count)
                        count)))))))