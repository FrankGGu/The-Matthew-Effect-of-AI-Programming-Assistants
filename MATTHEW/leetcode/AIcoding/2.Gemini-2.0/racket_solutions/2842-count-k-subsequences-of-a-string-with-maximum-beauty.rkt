(define (count-k-subsequences s k)
  (define (char-to-int c)
    (- (char->integer c) (char->integer #\a)))

  (define (int-to-char i)
    (integer->char (+ i (char->integer #\a))))

  (define (solve idx curr-seq curr-beauty)
    (cond
      [(= idx (string-length s))
       (if (= (length curr-seq) k)
           curr-beauty
           0)]
      [else
       (let* ([next-char (string-ref s idx)]
              [next-int (char-to-int next-char)]
              [count-with (solve (+ idx 1) (append curr-seq (list next-int)) (* curr-beauty (+ 1 (expt next-int 1))))]
              [count-without (solve (+ idx 1) curr-seq curr-beauty)])
         (modulo (+ count-with count-without) 1000000007))]))

  (solve 0 '() 1))