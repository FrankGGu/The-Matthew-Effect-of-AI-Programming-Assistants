(define (valid-utf8? data)
  (let loop ([i 0] [remaining-bytes 0])
    (cond
      [(= i (length data)) (= remaining-bytes 0)]
      [(= remaining-bytes 0)
       (let ([num (list-ref data i)])
         (cond
           [(bitwise-bit-set? num 7)
            (let ([count 0])
              (let count-bits ([j 7])
                (when (and (>= j 0) (bitwise-bit-set? num j))
                  (set! count (add1 count))
                  (count-bits (sub1 j))))
              (if (or (= count 1) (> count 4))
                  #f
                  (loop (add1 i) (sub1 count))))]
           [else (loop (add1 i) 0)]))]
      [else
       (let ([num (list-ref data i)])
         (if (and (bitwise-bit-set? num 7) (not (bitwise-bit-set? num 6)))
             (loop (add1 i) (sub1 remaining-bytes))
             #f))])))