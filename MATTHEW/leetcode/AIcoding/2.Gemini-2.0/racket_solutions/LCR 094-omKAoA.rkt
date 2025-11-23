(define (min-cut s)
  (let* ([n (string-length s)]
         [is-palindrome? (make-vector n #f)]
         [cuts (make-vector n 0)])

    (for ([i (in-range n)])
      (set! (vector-ref is-palindrome? i) (make-vector n #f)))

    (for ([i (in-range n)])
      (for ([j (in-range i -1 -1)])
        (if (and (string=? (substring s j (+ j 1)) (substring s i (+ i 1)))
                 (or (= (- i j) 1) (vector-ref (vector-ref is-palindrome? (+ j 1)) (- i 1))))
            (vector-set! (vector-ref is-palindrome? j) i #t))))

    (for ([i (in-range n)])
      (if (vector-ref (vector-ref is-palindrome? 0) i)
          (vector-set! cuts i 0)
          (let ([min-val (add1 i)])
            (for ([j (in-range 1 (+ i 1))])
              (if (vector-ref (vector-ref is-palindrome? j) i)
                  (set! min-val (min min-val (add1 (vector-ref cuts (- j 1)))))))
            (vector-set! cuts i min-val))))
    (vector-ref cuts (- n 1))))