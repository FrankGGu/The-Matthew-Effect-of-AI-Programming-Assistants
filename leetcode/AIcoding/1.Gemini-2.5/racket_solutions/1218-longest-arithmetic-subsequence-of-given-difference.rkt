(define (longest-arith-seq-of-diff arr difference)
  (let ([dp (make-hash)]
        [max-len 0])
    (for-each (lambda (n)
                (let* ([prev-num (- n difference)]
                       [prev-len (hash-ref dp prev-num 0)]
                       [current-len (+ prev-len 1)])
                  (hash-set! dp n current-len)
                  (set! max-len (max max-len current-len))))
              arr)
    max-len))