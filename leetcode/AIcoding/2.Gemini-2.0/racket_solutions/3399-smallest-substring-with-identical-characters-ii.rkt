(define (smallest-substring-with-identical-characters-ii s k)
  (define n (string-length s))
  (define (check-valid sub)
    (let ([counts (make-hash)])
      (for ([c (in-string sub)])
        (hash-update! counts c (λ (x) (+ x 1)) 1))
      (if (empty? counts)
          #f
          (let ([max-count (apply max (hash-values counts))])
            (>= max-count k)))))

  (let loop ([len 1])
    (if (> len n)
        -1
        (let loop2 ([i 0])
          (if (>= i (- n len) 1))
              (loop (+ len 1))
              (let ([sub (substring s i (+ i len))])
                (if (check-valid sub)
                    len
                    (loop2 (+ i 1)))))))))