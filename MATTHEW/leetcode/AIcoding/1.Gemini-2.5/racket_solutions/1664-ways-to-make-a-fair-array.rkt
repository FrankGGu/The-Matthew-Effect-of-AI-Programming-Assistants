(define (ways-to-make-fair-array nums)
  (define n (vector-length nums))

  (define even-prefix (make-vector (+ n 1) 0))
  (define odd-prefix (make-vector (+ n 1) 0))

  (for ([i (in-range n)])
    (vector-set! even-prefix (+ i 1) (vector-ref even-prefix i))
    (vector-set! odd-prefix (+ i 1) (vector-ref odd-prefix i))
    (if (even? i)
        (vector-set! even-prefix (+ i 1) (+ (vector-ref even-prefix (+ i 1)) (vector-ref nums i)))
        (vector-set! odd-prefix (+ i 1) (+ (vector-ref odd-prefix (+ i 1)) (vector-ref nums i)))))

  (define total-even-sum (vector-ref even-prefix n))
  (define total-odd-sum (vector-ref odd-prefix n))

  (define fair-count 0)
  (for ([i (in-range n)])
    (define current-even-sum
      (+ (vector-ref even-prefix i)
         (- total-odd-sum (vector-ref odd-prefix (+ i 1)))))
    (define current-odd-sum
      (+ (vector-ref odd-prefix i)
         (- total-even-sum (vector-ref even-prefix (+ i 1)))))
    (when (= current-even-sum current-odd-sum)
      (set! fair-count (+ fair-count 1))))

  fair-count)