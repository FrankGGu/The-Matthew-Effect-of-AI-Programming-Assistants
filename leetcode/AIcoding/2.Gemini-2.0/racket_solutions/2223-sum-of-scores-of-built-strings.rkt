(define (sum-scores s)
  (define n (string-length s))
  (define z (make-vector n 0))

  (define (z-algorithm)
    (let loop ([l 0] [r 0] [i 1])
      (cond
        [(>= i n) (void)]
        [else
         (if (> r i)
             (let ([k (- i l)])
               (if (< (vector-ref z k) (- r i))
                   (vector-set! z i (vector-ref z k))
                   (let loop2 ([j (- r i)])
                     (if (and (<= (+ r j) (- n 1)) (char=? (string-ref s (+ r j)) (string-ref s (+ r j i))))
                         (loop2 (+ j 1))
                         (begin
                           (vector-set! z i j)
                           (set! l i)
                           (set! r (+ i j))
                           (loop (+ i 1) r (+ i 1))))))
               )
             (let loop3 ([j 0])
               (if (and (<= (+ i j) (- n 1)) (char=? (string-ref s j) (string-ref s (+ i j))))
                   (loop3 (+ j 1))
                   (begin
                     (vector-set! z i j)
                     (if (> (+ i j) r)
                         (loop i (+ i j) (+ i 1))
                         (loop (+ i 1) r (+ i 1)))))))
         (loop (+ i 1) r (+ i 1))])))

  (define (compute-z-array)
    (let loop ([i 1] [len 0])
      (cond
        [(>= i n) len]
        [else
         (if (char=? (string-ref s 0) (string-ref s i))
             (loop (+ i 1) (+ len 1))
             len)])))

  (vector-set! z 0 n)
  (let ([len (compute-z-array)])
    (vector-set! z 1 len)
    (z-algorithm))

  (let loop ([i 0] [sum 0])
    (if (= i n)
        sum
        (loop (+ i 1) (+ sum (vector-ref z i))))))
)