(define (max-sum-of-three-subarrays nums k)
  (define n (length nums))
  (define (sum subarray)
    (apply + subarray))
  (define sums (map (lambda (i) (sum (sublist nums i (+ i k)))) (range 0 (- n k 1))))
  (define total-sums (map (lambda (i) (apply + (sublist sums i (+ i k)))) (range 0 (- (length sums) k 1))))

  (define max-sum -1)
  (define best-idxs '())

  (for ((i (in-range k (- (length total-sums) k))))
    (let ((current-sum (+ (list-ref sums i)
                          (list-ref total-sums i)
                          (list-ref total-sums (+ i k)))))
      (when (> current-sum max-sum)
        (set! max-sum current-sum)
        (set! best-idxs (list i (+ i k) (+ i (* 2 k)))))))

  best-idxs)

(max-sum-of-three-subarrays '(1 2 1 2 6 7 5 1) 2)