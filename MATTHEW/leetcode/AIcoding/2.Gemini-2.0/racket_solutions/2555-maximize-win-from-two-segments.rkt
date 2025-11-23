(define (maximize-win-from-two-segments prize-buckets first-len second-len)
  (define n (length prize-buckets))
  (define prefix-sums (make-vector (+ n 1) 0))
  (for/list ([i (in-range 1 (+ n 1))])
    (vector-set! prefix-sums i (+ (vector-ref prefix-sums (- i 1)) (list-ref prize-buckets (- i 1)))))

  (define (sum-range start end)
    (- (vector-ref prefix-sums (+ end 1)) (vector-ref prefix-sums start)))

  (define (solve-first-segment)
    (define max-second-segment (make-vector n 0))
    (for/list ([i (in-range 0 (- n second-len))])
      (vector-set! max-second-segment i (sum-range i (+ i second-len -1))))

    (let loop ([i (- n first-len)] [max-so-far 0])
      (if (< i 0)
          max-so-far
          (let* ([current-sum (sum-range i (+ i first-len -1))]
                 [remaining-end (- i 1)]
                 [best-second-segment (if (>= remaining-end 0)
                                            (apply max (vector->list (subvector max-second-segment 0 (+ remaining-end 1))))
                                            0)])
            (loop (- i 1) (max max-so-far (+ current-sum best-second-segment)))))))

  (define (solve-second-segment)
    (define max-first-segment (make-vector n 0))
    (for/list ([i (in-range 0 (- n first-len))])
      (vector-set! max-first-segment i (sum-range i (+ i first-len -1))))

    (let loop ([i (- n second-len)] [max-so-far 0])
      (if (< i 0)
          max-so-far
          (let* ([current-sum (sum-range i (+ i second-len -1))]
                 [remaining-end (- i 1)]
                 [best-first-segment (if (>= remaining-end 0)
                                           (apply max (vector->list (subvector max-first-segment 0 (+ remaining-end 1))))
                                           0)])
            (loop (- i 1) (max max-so-far (+ current-sum best-first-segment)))))))

  (max (solve-first-segment) (solve-second-segment)))