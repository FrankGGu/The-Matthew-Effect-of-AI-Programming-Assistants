(define (count-substrings s)
  (define n (string-length s))
  (define (char->int c) (- (char->integer c) (char->integer #\0)))
  (let loop ([i 0] [res 0] [count0 0] [count1 0])
    (cond
      [(= i n) res]
      [else
       (let* ([c (char->int (string-ref s i))]
         (cond
           [(= c 1)
            (loop (+ i 1) (+ res (+ count1 1)) 0 (+ count1 1))]
           [else
            (loop (+ i 1) res (+ count0 1) 0)]))])))