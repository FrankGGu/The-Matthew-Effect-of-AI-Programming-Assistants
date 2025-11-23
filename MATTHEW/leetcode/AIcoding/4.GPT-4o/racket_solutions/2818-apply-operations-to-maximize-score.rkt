(define (applyOperations nums)
  (define n (length nums))
  (define new-nums (make-vector n 0))
  (define j 0)

  (for ([i (in-range n)])
    (when (and (< i (- n 1)) (= (vector-ref nums i) (vector-ref nums (+ i 1))))
      (vector-set! new-nums j (* 2 (vector-ref nums i)))
      (set! i (+ i 1))
      (set! j (+ j 1)))
    (when (not (= (vector-ref nums i) (vector-ref nums (+ i 1))))
      (vector-set! new-nums j (vector-ref nums i))
      (set! j (+ j 1))))

  (let loop ([i j] [score 0])
    (if (>= i n)
        score
        (loop (+ i 1) (+ score (vector-ref new-nums i))))))

(define (maximumScore nums)
  (applyOperations nums))