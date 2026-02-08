(define (num-distinct s t)
  (define s-len (string-length s))
  (define t-len (string-length t))

  (define dp (make-vector (+ s-len 1)))

  (for ([i (in-range (+ s-len 1))])
    (vector-set! dp i (make-vector (+ t-len 1) 0)))

  (for ([i (in-range (+ s-len 1))])
    (vector-set! (vector-ref dp i) 0 1))

  (for ([i (in-range 1 (+ s-len 1))])
    (for ([j (in-range 1 (+ t-len 1))])
      (define s-char (string-ref s (sub1 i)))
      (define t-char (string-ref t (sub1 j)))

      (if (char=? s-char t-char)
          (vector-set! (vector-ref dp i) j
                       (+ (vector-ref (vector-ref dp (sub1 i)) (sub1 j))
                          (vector-ref (vector-ref dp (sub1 i)) j)))
          (vector-set! (vector-ref dp i) j
                       (vector-ref (vector-ref dp (sub1 i)) j)))))

  (vector-ref (vector-ref dp s-len) t-len))