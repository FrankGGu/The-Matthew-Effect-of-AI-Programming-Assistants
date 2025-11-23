(define (count-good-substrings s)
  (let loop ([i 0] [count 0])
    (if (>= i (- (string-length s) 2))
        count
        (let ([sub (substring s i (+ i 3))])
          (if (and (= (string-length (remove-duplicates (string->list sub))) 3))
              (loop (+ i 1) (+ count 1))
              (loop (+ i 1) count))))))