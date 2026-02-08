(define (max-frequency s max-letters min-size max-size)
  (define (count-letters substring)
    (foldl (lambda (c acc) (if (char? c) (add1 acc) acc)) 0 substring))

  (define (valid-substring? substring)
    (and (<= (count-letters substring) max-letters)
         (>= (string-length substring) min-size)
         (<= (string-length substring) max-size)))

  (define substrings
    (for/list ((i (in-range (string-length s))))
      (for/list ((j (in-range i (min (+ i max-size) (string-length s)))))
        (substring s i (add1 j)))))

  (define counts (hash))

  (for-each (lambda (substring)
              (when (valid-substring? substring)
                (hash-set! counts substring (add1 (hash-ref counts substring 0)))))
            (apply append substrings))

  (apply max (hash-values counts 0)))

(max-frequency "aababcaab" 2 3 4)