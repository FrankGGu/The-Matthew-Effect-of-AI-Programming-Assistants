(define (wonderful-substrings s)
  (let* ([n (string-length s)]
         [freq (make-vector 1024 0)]
         [count 0]
         [current-mask 0])

    (vector-set! freq 0 1)

    (for ([i (in-range n)])
      (let* ([char-code (char->integer (string-ref s i))]
             [bit-pos (- char-code (char->integer #\a))])

        (set! current-mask (bitwise-xor current-mask (arithmetic-shift 1 bit-pos)))

        (set! count (+ count (vector-ref freq current-mask)))

        (for ([k (in-range 10)])
          (let ([target-mask (bitwise-xor current-mask (arithmetic-shift 1 k))])
            (set! count (+ count (vector-ref freq target-mask)))))

        (vector-set! freq current-mask (+ (vector-ref freq current-mask) 1))))

    count))