(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (max-score nums)
  (define n (length nums))
  (define memo (make-hash))

  (define (solve mask op)
    (cond
      [(= op (/ n 2)) 0]
      [(hash-has-key? memo (cons mask op)) (hash-ref memo (cons mask op))]
      [else
       (let loop ([i 0] [max-val 0])
         (if (= i n)
             (begin
               (hash-set! memo (cons mask op) max-val)
               max-val)
             (if (zero? (bitwise-and mask (expt 2 i)))
                 (let loop2 ([j (+ i 1)])
                   (if (= j n)
                       max-val
                       (if (zero? (bitwise-and mask (expt 2 j)))
                           (let* ([new-mask (bitwise-ior mask (bitwise-ior (expt 2 i) (expt 2 j)))]
                                  [score (+ (* op (gcd (list-ref nums i) (list-ref nums j))) (solve new-mask (+ op 1)))])
                             (loop2 (+ j 1) (max max-val score)))
                           (loop2 (+ j 1) max-val))))
                 (loop (+ i 1) max-val))))))

  (solve 0 1))