(define (get-hint secret guess)
  (let* ([n (string-length secret)]
         [bulls 0]
         [cows 0]
         [secret-counts (make-vector 10 0)]
         [guess-counts (make-vector 10 0)])

    (define (char-to-digit char-val)
      (- (char->integer char-val) (char->integer #\0)))

    (for ([i (in-range n)])
      (let ([s-char (string-ref secret i)]
            [g-char (string-ref guess i)])
        (if (char=? s-char g-char)
            (set! bulls (+ bulls 1))
            (begin
              (let ([s-digit (char-to-digit s-char)]
                    [g-digit (char-to-digit g-char)])
                (vector-set! secret-counts s-digit (+ (vector-ref secret-counts s-digit) 1))
                (vector-set! guess-counts g-digit (+ (vector-ref guess-counts g-digit) 1))))))))

    (for ([i (in-range 10)])
      (set! cows (+ cows (min (vector-ref secret-counts i) (vector-ref guess-counts i)))))

    (format "~aA~aB" bulls cows)))