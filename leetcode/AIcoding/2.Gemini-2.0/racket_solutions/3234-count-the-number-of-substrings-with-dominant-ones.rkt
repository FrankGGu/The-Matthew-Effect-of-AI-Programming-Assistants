(define (count-substrings-with-dominant-ones s)
  (define n (string-length s))
  (define (dominant-ones? sub)
    (define ones (count (lambda (c) (char=? c #\1)) (string->list sub)))
    (define zeros (- (string-length sub) ones))
    (> ones zeros))

  (let loop ([i 0] [count 0])
    (if (= i n)
        count
        (let loop2 ([j i] [count2 count])
          (if (= j n)
              count2
              (let ([sub (substring s i (+ j 1))])
                (if (dominant-ones? sub)
                    (loop2 (+ j 1) (+ count2 1))
                    (loop2 (+ j 1) count2)))))))

)