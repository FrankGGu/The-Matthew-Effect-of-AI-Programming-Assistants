#lang racket

(define (reverse-pairs nums)
  (define (merge-sort arr start end)
    (if (>= start end)
        0
        (let* ([mid (quotient (+ start end) 2)]
               [left-count (merge-sort arr start mid)]
               [right-count (merge-sort arr (+ mid 1) end)]
               [cross-count (count-cross arr start mid end)])
          (+ left-count right-count cross-count))))

  (define (count-cross arr start mid end)
    (let* ([temp (make-vector (- end start + 1))]
           [i start]
           [j (+ mid 1)]
           [k 0]
           [count 0])
      (while (and (<= i mid) (<= j end))
        (if (<= (vector-ref arr i) (vector-ref arr j))
            (begin
              (vector-set! temp k (vector-ref arr i))
              (set! i (+ i 1)))
            (begin
              (vector-set! temp k (vector-ref arr j))
              (set! count (+ count (- mid i + 1)))
              (set! j (+ j 1)))
            (set! k (+ k 1))))
      (while (<= i mid)
        (vector-set! temp k (vector-ref arr i))
        (set! i (+ i 1))
        (set! k (+ k 1)))
      (while (<= j end)
        (vector-set! temp k (vector-ref arr j))
        (set! j (+ j 1))
        (set! k (+ k 1)))
      (let loop ([i 0] [j start])
        (when (< i (vector-length temp))
          (vector-set! arr j (vector-ref temp i))
          (loop (+ i 1) (+ j 1))))
      count))

  (merge-sort nums 0 (- (vector-length nums) 1)))