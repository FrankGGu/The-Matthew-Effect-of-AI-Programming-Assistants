(define (last-substring s)
  (let loop ([i 0] [j 1] [k 0])
    (cond
      [(>= (+ j k) (string-length s)) i]
      [(= (char->integer (string-ref s (+ i k)))
          (char->integer (string-ref s (+ j k))))
       (loop i j (+ k 1))]
      [(> (char->integer (string-ref s (+ i k)))
          (char->integer (string-ref s (+ j k))))
       (loop i (+ j k 1) 0)]
      [else (loop (+ i k 1) (max (+ i k 1) (+ j 1)) 0])))