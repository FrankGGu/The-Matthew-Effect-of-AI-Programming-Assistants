(define (count-substrings s char)
  (define n (string-length s))
  (define (helper i count)
    (cond [(>= i n) count]
          [(and (char=? (string-ref s i) char)
                (char=? (string-ref s 0) char)) (+ count 1)]
          [(char=? (string-ref s i) char)
           (let loop ([j 0] [acc 0])
             (cond [(>= j i) (+ acc count)]
                   [(char=? (string-ref s j) char) (loop (+ j 1) (+ acc 1))]
                   [else (loop (+ j 1) acc)]))]
          [else (helper (+ i 1) count)]))
  (helper 0 0))

(provide count-substrings)