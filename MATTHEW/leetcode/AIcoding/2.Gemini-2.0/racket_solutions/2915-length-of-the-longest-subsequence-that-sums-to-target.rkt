(define (length-of-longest-subsequence nums target)
  (define n (length nums))
  (define dp (make-vector (+ n 1) (make-vector (+ target 1) -1)))

  (vector-set! (vector-ref dp 0) 0 0)

  (for ([i (in-range 1 (+ n 1))])
    (for ([j (in-range 0 (+ target 1))])
      (let ([num (list-ref nums (- i 1))])
        (if (>= j num)
            (let ([prev-without-num (vector-ref (vector-ref dp (- i 1)) j)]
                  [prev-with-num (vector-ref (vector-ref dp (- i 1)) (- j num))])
              (if (and (= prev-without-num -1) (= prev-with-num -1))
                  (vector-set! (vector-ref dp i) j -1)
                  (cond
                    [(and (= prev-without-num -1) (not (= prev-with-num -1)))
                     (vector-set! (vector-ref dp i) j (+ prev-with-num 1))]
                    [(and (not (= prev-without-num -1)) (= prev-with-num -1))
                     (vector-set! (vector-ref dp i) j prev-without-num)]
                    [else
                     (vector-set! (vector-ref dp i) j (max prev-without-num (+ prev-with-num 1)))])))
            (vector-set! (vector-ref dp i) j (vector-ref (vector-ref dp (- i 1)) j))))))

  (vector-ref (vector-ref dp n) target))