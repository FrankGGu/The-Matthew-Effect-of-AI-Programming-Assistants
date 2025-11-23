(define (are-distinct-counts-equal word1 word2)
  (define (count-freqs s)
    (define freqs (make-vector 26 0))
    (for ([c (in-string s)])
      (vector-set! freqs (- (char->integer c) (char->integer #\a))
                   (+ (vector-ref freqs (- (char->integer c) (char->integer #\a))) 1)))
    freqs)

  (define (count-distinct freqs)
    (define distinct-count 0)
    (for ([i (in-range 26)])
      (when (> (vector-ref freqs i) 0)
        (set! distinct-count (+ distinct-count 1))))
    distinct-count)

  (define freqs1-orig (count-freqs word1))
  (define freqs2-orig (count-freqs word2))

  (for/first ([c1-idx (in-range 26)]
              [c2-idx (in-range 26)])
    (when (and (> (vector-ref freqs1-orig c1-idx) 0)
               (> (vector-ref freqs2-orig c2-idx) 0))

      (define freqs1-temp (vector-copy freqs1-orig))
      (define freqs2-temp (vector-copy freqs2-orig))

      (vector-set! freqs1-temp c1-idx (- (vector-ref freqs1-temp c1-idx) 1))
      (vector-set! freqs1-temp c2-idx (+ (vector-ref freqs1-temp c2-idx) 1))

      (vector-set! freqs2-temp c2-idx (- (vector-ref freqs2-temp c2-idx) 1))
      (vector-set! freqs2-temp c1-idx (+ (vector-ref freqs2-temp c1-idx) 1))

      (when (= (count-distinct freqs1-temp) (count-distinct freqs2-temp))
        #t))
    #f))