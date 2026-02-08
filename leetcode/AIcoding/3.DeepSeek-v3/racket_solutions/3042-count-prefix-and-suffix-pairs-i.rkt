(define (count-prefix-suffix-pairs words)
  (define n (length words))
  (let loop ([i 0] [count 0])
    (if (>= i n)
        count
        (let loop2 ([j (add1 i)] [current-count count])
          (if (>= j n)
              (loop (add1 i) current-count)
              (let* ([s1 (list-ref words i)]
                     [s2 (list-ref words j)]
                     [len1 (string-length s1)]
                     [len2 (string-length s2)])
                (if (and (>= len2 len1)
                         (string=? (substring s2 0 len1) s1)
                         (string=? (substring s2 (- len2 len1) len2) s1))
                    (loop2 (add1 j) (add1 current-count))
                    (loop2 (add1 j) current-count))))))))