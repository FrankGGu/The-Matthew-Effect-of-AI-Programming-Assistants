(define (max-chunks-to-sorted-string s k)
  (let loop ([i 0] [count 0] [curr 0])
    (if (= i (string-length s))
        count
        (let ([digit (string->number (string (string-ref s i)))])
          (cond
            [(> digit k) -1]
            [(> (+ curr digit) k)
             (loop i (+ count 1) 0)]
            [else
             (loop (+ i 1) count (+ (* curr 10) digit))])))))