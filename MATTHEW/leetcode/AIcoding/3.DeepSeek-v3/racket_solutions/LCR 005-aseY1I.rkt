(define (max-product words)
  (define (word-to-bits word)
    (for/fold ([bits 0])
              ([c (in-string word)])
      (bitwise-ior bits (arithmetic-shift 1 (- (char->integer c) (char->integer #\a))))))

  (define n (length words))
  (define masks (map word-to-bits words))
  (define max-prod 0)

  (for* ([i (in-range n)]
         [j (in-range (add1 i) n)])
    (when (zero? (bitwise-and (list-ref masks i) (list-ref masks j)))
      (set! max-prod (max max-prod (* (string-length (list-ref words i)) (string-length (list-ref words j))))))

  max-prod)