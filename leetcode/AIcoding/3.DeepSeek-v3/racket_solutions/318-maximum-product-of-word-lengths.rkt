(define/contract (max-product words)
  (-> (listof string?) exact-integer?)
  (define (word-to-bits word)
    (for/fold ([bits 0])
              ([c (in-string word)])
      (bitwise-ior bits (arithmetic-shift 1 (- (char->integer c) (char->integer #\a))))))

  (define bit-masks (map word-to-bits words))
  (define len (length words))

  (define max-p 0)
  (for* ([i (in-range len)]
         [j (in-range (add1 i) len)])
    (when (zero? (bitwise-and (list-ref bit-masks i) (list-ref bit-masks j)))
      (set! max-p (max max-p (* (string-length (list-ref words i)) (string-length (list-ref words j)))))))
  max-p)