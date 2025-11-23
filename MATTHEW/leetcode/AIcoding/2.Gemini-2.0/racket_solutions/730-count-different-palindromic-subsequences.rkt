(define (count-palindromic-subsequences s)
  (define n (string-length s))
  (define dp (make-vector (+ n 1) (make-vector (+ n 1) (make-vector 4 0))))
  (define MOD 1000000007)

  (define (char-index c)
    (case c
      [(#\a) 0]
      [(#\b) 1]
      [(#\c) 2]
      [(#\d) 3]))

  (for ((i (in-range 1 (+ n 1))))
    (vector-set! (vector-ref dp i i) (char-index (string-ref s (- i 1))) 1))

  (for ((len (in-range 2 (+ n 1))))
    (for ((i (in-range 1 (- (+ n 1) len -1))))
      (define j (+ i len -1))
      (for ((k (in-range 0 4)))
        (define c (case k
                     [(0) #\a]
                     [(1) #\b]
                     [(2) #\c]
                     [(3) #\d]))
        (if (and (char=? (string-ref s (- i 1)) c) (char=? (string-ref s (- j 1)) c))
            (let* ((inside-sum (foldl (lambda (x acc) (modulo (+ acc (vector-ref (vector-ref dp (+ i 1) (- j 1)) x)) MOD)) 0 (in-range 0 4)))
                   (equal-count 0))
              (for ((l (in-range 0 4)))
                (if (and (char=? (string-ref s (- i 1)) (case l [(0) #\a] [(1) #\b] [(2) #\c] [(3) #\d]))
                         (char=? (string-ref s (- i 1)) (string-ref s (- (+ i 1) 1))))
                    (set! equal-count (modulo (+ equal-count (vector-ref (vector-ref dp (+ i 1) (- j 1)) l)) MOD))))
              (vector-set! (vector-ref dp i j) k (modulo (+ inside-sum (- equal-count (if (or (char=? (string-ref s (- i 1)) (string-ref s (- (+ i 1) 1)))
                                                                                               (char=? (string-ref s (- i 1)) (string-ref s (- j 1)))) 0 0)) MOD))
              )
            (if (char=? (string-ref s (- i 1)) c)
                (vector-set! (vector-ref dp i j) k (vector-ref (vector-ref dp (+ i 1) j) k))
                (if (char=? (string-ref s (- j 1)) c)
                    (vector-set! (vector-ref dp i j) k (vector-ref (vector-ref dp i (- j 1)) k))
                    (vector-set! (vector-ref dp i j) k (vector-ref (vector-ref dp (+ i 1) (- j 1)) k))))))))

  (foldl (lambda (x acc) (modulo (+ acc (vector-ref (vector-ref dp 1 n) x)) MOD)) 0 (in-range 0 4)))