(define (longest-substring one-repeating-character s)
  (define n (string-length s))
  (define (helper k)
    (let loop ((i 0) (start 0) (max-len 0) (diff-count 0))
      (cond
        [(>= i n)
         (max max-len (- n start))]
        [(= (string-ref s i) k)
         (loop (+ i 1) start max-len diff-count)]
        [(and (< diff-count 1) (< i n))
         (loop (+ i 1) start (max max-len (- i start)) (+ diff-count 1))]
        [else
         (let loop2 ((j (+ start 1)))
           (cond
             [(= (string-ref s j) k)
              (loop (+ i 1) j (max max-len (- i j)) 0)]
             [else
              (loop2 (+ j 1))]))])))
  (let ([ans (max (helper #\A) (helper #\B) (helper #\C) (helper #\D) (helper #\E) (helper #\F) (helper #\G) (helper #\H) (helper #\I) (helper #\J) (helper #\K) (helper #\L) (helper #\M) (helper #\N) (helper #\O) (helper #\P) (helper #\Q) (helper #\R) (helper #\S) (helper #\T) (helper #\U) (helper #\V) (helper #\W) (helper #\X) (helper #\Y) (helper #\Z))])
    ans))