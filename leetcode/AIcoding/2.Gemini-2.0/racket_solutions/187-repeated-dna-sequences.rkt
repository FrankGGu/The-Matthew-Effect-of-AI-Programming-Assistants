(define (find-repeated-dna-sequences s k)
  (define n (string-length s))
  (if (< n k)
      '()
      (let loop ([i 0] [seen (hash)] [result '()])
        (if (>= i (- n k -1))
            result
            (let ([sub (substring s i (+ i k))])
              (if (hash-has-key? seen sub)
                  (if (not (member sub result))
                      (loop (+ i 1) seen (cons sub result))
                      (loop (+ i 1) seen result))
                  (begin
                    (hash-set! seen sub #t)
                    (loop (+ i 1) seen result))))))))

(define (repeated-dna-sequences s)
  (find-repeated-dna-sequences s 10))