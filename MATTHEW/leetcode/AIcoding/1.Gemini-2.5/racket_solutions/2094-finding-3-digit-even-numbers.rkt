(define (find-even-numbers digits)
  (let* ([n (length digits)]
         [results (make-hasheq)]
         [digits-vec (list->vector digits)])
    (for ([i (in-range n)])
      (for ([j (in-range n)])
        (unless (= i j)
          (for ([k (in-range n)])
            (unless (or (= k i) (= k j))
              (let* ([d1 (vector-ref digits-vec i)]
                     [d2 (vector-ref digits-vec j)]
                     [d3 (vector-ref digits-vec k)])
                (when (and (not (= d1 0))
                           (even? d3))
                  (let ([num (+ (* d1 100) (* d2 10) d3)])
                    (hash-set! results num #t))))))))))
    (sort (hash-keys results) <)))