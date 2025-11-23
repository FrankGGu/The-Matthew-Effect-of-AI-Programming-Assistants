(define (check-zero-ones s)
  (define (max-run-length c)
    (let loop ([i 0] [current 0] [max-len 0])
      (if (>= i (string-length s))
          max-len
          (if (char=? (string-ref s i) c)
              (loop (+ i 1) (+ current 1) (max max-len (+ current 1)))
              (loop (+ i 1) 0 max-len)))))
  (let ([max-ones (max-run-length #\1)]
        [max-zeros (max-run-length #\0)])
    (> max-ones max-zeros)))