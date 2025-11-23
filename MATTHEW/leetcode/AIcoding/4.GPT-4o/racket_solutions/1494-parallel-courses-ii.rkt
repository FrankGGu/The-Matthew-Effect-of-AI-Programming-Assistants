(define (minNumberOfSemesters n relations k)
  (define dp (make-vector (expt 2 n) (make-vector n #f)))
  (define (bit-count x)
    (if (= x 0) 0
        (+ (if (odd? x) 1 0) (bit-count (ash x -1)))))

  (define (can-take-semester mask)
    (for/fold ([result #t]) ([i (in-range n)])
      (if (and (bitwise-and mask (ash 1 i))
               (any (lambda (j) (and (bitwise-and mask (ash 1 j)) (not (vector-ref dp (ash 1 j)))))
                    (for/list ([j (in-range n)])))
               (not (vector-ref dp (ash 1 i))))
          #f
          result)))

  (define (dp-solve mask)
    (if (= mask (sub1 (expt 2 n)))
        0
        (if (vector-ref dp mask)
            (vector-ref dp mask)
            (let loop ([best (infinity)] [count 0])
              (for ([i (in-range n)])
                (when (and (not (vector-ref dp (ash 1 i))) (bitwise-and mask (ash 1 i)))
                  (define next-mask (bitwise-or mask (ash 1 i)))
                  (when (can-take-semester next-mask)
                    (loop (min best (+ 1 (dp-solve next-mask))) (add1 count)))))
              (vector-set! dp mask best)
              best))))

  (dp-solve 0))

(minNumberOfSemesters n relations k)