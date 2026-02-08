(define (max-product words)
  (define (word-to-bitmask word)
    (foldl (lambda (char acc) (bitwise-or acc (ash 1 (- (char->integer char) (char->integer #\a))))) 0 word))

  (define n (length words))
  (define masks (map word-to-bitmask words))
  (define max-product 0)

  (for ((i (in-range n)))
    (for ((j (in-range (+ i 1) n)))
      (when (zero? (bitwise-and (list-ref masks i) (list-ref masks j)))
        (set! max-product (max max-product (* (string-length (list-ref words i)) (string-length (list-ref words j))))))))

  max-product)

(define (maxProduct words)
  (max-product words))