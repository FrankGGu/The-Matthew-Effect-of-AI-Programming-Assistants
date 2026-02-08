(provide (contract-out
          [take-k-of-each-character-from-left-and-right (-> string? integer? integer?)]))

(define (take-k-of-each-character-from-left-and-right s k)
  (define n (string-length s))

  (define (check-valid? left-count right-count)
    (let ([counts (make-hash)])
      (for ([i (in-range left-count)])
        (let ([c (string-ref s i)])
          (hash-update! counts c add1 0)))
      (for ([i (in-range (- n right-count) n)])
        (let ([c (string-ref s i)])
          (hash-update! counts c add1 0)))
      (and (>= (hash-ref counts #\a 0) k)
           (>= (hash-ref counts #\b 0) k)
           (>= (hash-ref counts #\c 0) k))))

  (let loop ([left-count 0]
             [right-count 0]
             [min-length n])
    (cond
      [(> (+ left-count right-count) n) min-length]
      [(check-valid? left-count right-count)
       (loop left-count (add1 right-count) (min min-length (+ left-count right-count)))]
      [else
       (loop (add1 left-count) right-count min-length)])))