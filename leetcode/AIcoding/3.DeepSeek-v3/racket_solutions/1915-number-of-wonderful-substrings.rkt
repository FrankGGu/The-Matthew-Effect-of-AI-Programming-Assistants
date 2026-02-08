(define (wonderful-substrings word)
  (let loop ([i 0] [mask 0] [count 0] [freq (make-hash '((0 . 1)))])
    (if (>= i (string-length word))
        count
        (let* ([c (string-ref word i)]
               [bit (- (char->integer c) (char->integer #\a))]
               [new-mask (bitwise-xor mask (arithmetic-shift 1 bit))]
               [new-count (+ count (hash-ref freq new-mask 0))])
          (for ([k 10])
            (let ([temp-mask (bitwise-xor new-mask (arithmetic-shift 1 k))])
            (set! new-count (+ new-count (hash-ref freq temp-mask 0)))))
          (hash-update! freq new-mask add1 0)
          (loop (+ i 1) new-mask new-count freq)))))