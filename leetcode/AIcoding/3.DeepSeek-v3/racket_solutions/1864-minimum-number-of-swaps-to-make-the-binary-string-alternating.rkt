(define (min-swaps s)
  (define (count-char c str)
    (count (lambda (x) (char=? x c)) (string->list str)))

  (let* ([n (string-length s)]
         [count1 (count-char #\1 s)]
         [count0 (- n count1)])
    (cond
      [(> (abs (- count1 count0)) 1) -1]
      [else
       (let ([diff1 0] [diff2 0])
         (for ([i (in-range n)]
               [c (in-string s)])
           (if (even? i)
               (when (char=? c #\0) (set! diff1 (+ diff1 1)))
               (when (char=? c #\1) (set! diff1 (+ diff1 1)))))
         (for ([i (in-range n)]
               [c (in-string s)])
           (if (even? i)
               (when (char=? c #\1) (set! diff2 (+ diff2 1)))
               (when (char=? c #\0) (set! diff2 (+ diff2 1)))))
         (cond
           [(> count1 count0) (quotient diff1 2)]
           [(< count1 count0) (quotient diff2 2)]
           [else (min (quotient diff1 2) (quotient diff2 2))]))))