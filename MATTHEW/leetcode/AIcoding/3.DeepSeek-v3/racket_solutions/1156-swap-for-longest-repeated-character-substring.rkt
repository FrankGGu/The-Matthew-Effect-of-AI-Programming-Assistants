(define/contract (max-rep-opt1 text)
  (-> string? exact-integer?)
  (let* ([n (string-length text)]
         [counts (make-hash)]
         [left (make-vector n 0)]
         [right (make-vector n 0)]
         [res 0])
    (for ([i (in-range n)])
    (for ([i (in-range n)])
      (hash-update! counts (string-ref text i) add1 0))
    (for ([i (in-range n)])
    (vector-set! left 0 1)
    (for ([i (in-range 1 n)])
      (if (equal? (string-ref text i) (string-ref text (- i 1)))
          (vector-set! left i (+ (vector-ref left (- i 1)) 1))
          (vector-set! left i 1)))
    (vector-set! right (- n 1) 1)
    (for ([i (in-range (- n 2) -1 -1)])
      (if (equal? (string-ref text i) (string-ref text (+ i 1)))
          (vector-set! right i (+ (vector-ref right (+ i 1)) 1))
          (vector-set! right i 1)))
    (for ([i (in-range n)])
      (let ([c (string-ref text i)]
            [total (hash-ref counts c)]
            [l (if (> i 0) (vector-ref left (- i 1)) 0)]
            [r (if (< i (- n 1))) (vector-ref right (+ i 1)) 0)])
        (set! res (max res (min (+ l r 1) total))))
    res))