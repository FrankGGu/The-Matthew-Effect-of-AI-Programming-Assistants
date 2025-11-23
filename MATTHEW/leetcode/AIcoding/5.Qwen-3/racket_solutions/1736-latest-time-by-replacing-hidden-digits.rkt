(define (maximum-time-by-replacing-hidden-digits time)
  (define (char->int c)
    (- (char->integer c) 48))
  (define (int->char i)
    (integer->char (+ i 48)))
  (define lst (string->list time))
  (define (solve)
    (let ([h0 (car lst)]
          [h1 (cadr lst)]
          [m0 (caddr lst)]
          [m1 (cadddr lst)])
      (let ([h0 (if (char=? h0 #\?) (if (or (char=? h1 #\?) (<= (char->int h1) 3)) 2 1) (char->int h0))]
            [h1 (if (char=? h1 #\?) (if (= h0 2) 3 9) (char->int h1))]
            [m0 (if (char=? m0 #\?) 5  (char->int m0))]
            [m1 (if (char=? m1 #\?) 9  (char->int m1))])
        (list->string (map int->char (list h0 h1 m0 m1))))))
  (solve))