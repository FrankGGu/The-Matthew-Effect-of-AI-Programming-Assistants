(define (decodeAtIndex s k)
  (let* ([n (string-length s)]
         [sizes (make-vector (add1 n) 0)]
         [length 0])
    (for ([i (in-range n)])
      (let ([c (string-ref s i)])
        (if (char-numeric? c)
            (begin
              (set! length (* length (- (char->integer c) (char->integer #\0))))
              (vector-set! sizes (add1 i) length))
            (begin
              (set! length (add1 length))
              (vector-set! sizes (add1 i) length)))))
    (let loop ([k k] [i n])
      (cond
        [(= i 0) #f]
        [(= (vector-ref sizes i) k) (string-ref s (sub1 i))]
        [(< (vector-ref sizes i) k) #f]
        [else
         (let ([c (string-ref s (sub1 i))])
           (if (char-numeric? c)
               (let ([digit (- (char->integer c) (char->integer #\0))])
                 (loop (modulo k (/ (vector-ref sizes (sub1 i)) digit)) (sub1 i)))
               (if (= k (vector-ref sizes (sub1 i)))
                   (string-ref s (sub1 (sub1 i)))
                   (loop k (sub1 i)))))]))))