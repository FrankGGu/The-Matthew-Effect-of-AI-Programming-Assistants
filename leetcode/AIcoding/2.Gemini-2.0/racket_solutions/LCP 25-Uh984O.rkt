(define (print-string n s)
  (cond [(<= n 0) ""]
        [else (string-append s (print-string (- n 1) s))]))

(define (longest-repetition n)
  (let loop ([i 1] [res 0])
    (cond [(> i n) res]
          [else
           (let ([cur (let ([dp (make-vector (+ n 1) 0)])
                         (vector-set! dp 0 0)
                         (for ([j (in-range 1 (+ n 1))])
                           (let ([dp-j-1 (vector-ref dp (- j 1))])
                             (vector-set! dp j (max dp-j-1
                                                   (if (>= j i)
                                                       (+ (vector-ref dp (- j i)) 1)
                                                       0)))))
                         (vector-ref dp n))])
             (loop (+ i 1) (max res cur)))])))