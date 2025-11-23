#lang racket

(define (sum-of-floored-pairs nums)
  (define max-val (apply max nums))

  (define freq (make-vector (+ max-val 1) 0))
  (for-each (lambda (n)
              (vector-set! freq n (+ (vector-ref freq n) 1)))
            nums)

  (define prefix-sum-freq (make-vector (+ max-val 1) 0))
  (for i (in-range 1 (+ max-val 1))
    (vector-set! prefix-sum-freq i
                 (+ (vector-ref prefix-sum-freq (- i 1))
                    (vector-ref freq i))))

  (define total-sum 0)

  (for j (in-range 1 (+ max-val 1))
    (when (> (vector-ref freq j) 0)
      (define current-j-contribution 0)
      (for k (in-range 1 (add1 (quotient max-val j)))
        (define lower-bound (* k j))
        (define upper-bound (- (* (add1 k) j) 1))

        (define count-in-range
          (- (vector-ref prefix-sum-freq (min upper-bound max-val))
             (if (<= (- lower-bound 1) 0)
                 0
                 (vector-ref prefix-sum-freq (- lower-bound 1)))))

        (set! current-j-contribution (+ current-j-contribution (* k count-in-range))))

      (set! total-sum (+ total-sum (* (vector-ref freq j) current-j-contribution)))))

  total-sum)