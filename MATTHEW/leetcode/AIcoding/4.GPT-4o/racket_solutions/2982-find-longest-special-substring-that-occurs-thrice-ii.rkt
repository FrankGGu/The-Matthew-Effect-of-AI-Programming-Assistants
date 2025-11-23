(define (find-longest-special-substring s)
  (define (count-occurrences substring)
    (let loop ((start 0) (count 0))
      (if (>= start (string-length s))
          count
          (loop (+ start 1 (string-length substring)) 
                (if (string=? (substring s start (+ start (string-length substring))) substring)
                    (+ count 1)
                    count)))))

  (define (longest-special-substring length)
    (for/fold ([max-length 0]) ([i 1 (add1 length)])
      (if (and (= (count-occurrences (substring s 0 i)) 3) 
               (> i max-length))
          i
          max-length)))

  (for/fold ([max-length 0]) ([i (string-length s) 1])
    (longest-special-substring i)))

(find-longest-special-substring "abcabcabc")