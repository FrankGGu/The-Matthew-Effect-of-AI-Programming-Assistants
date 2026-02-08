(define (good-days-to-rob-bank security time)
  (define n (vector-length security))

  (define left-count (make-vector n 0))
  (define right-count (make-vector n 0))

  ;; Calculate left-count
  ;; left-count[i] = number of consecutive non-increasing steps ending at i
  ;; (i.e., security[i-k] >= ... >= security[i])
  (for ([i (in-range 1 n)])
    (when (>= (vector-ref security (- i 1)) (vector-ref security i))
      (vector-set! left-count i (+ (vector-ref left-count (- i 1)) 1))))

  ;; Calculate right-count
  ;; right-count[i] = number of consecutive non-decreasing steps starting at i
  ;; (i.e., security[i] <= ... <= security[i+k])
  (for ([i (in-range (- n 2) -1 -1)]) ; Loop from n-2 down to 0
    (when (<= (vector-ref security i) (vector-ref security (+ i 1)))
      (vector-set! right-count i (+ (vector-ref right-count (+ i 1)) 1))))

  ;; Collect good days
  (define result '())
  ;; A day i is good if time <= i < n - time
  ;; The valid range for i is [time, n - time - 1] inclusive
  (for ([i (in-range time (- n time))])
    (when (and (>= (vector-ref left-count i) time)
               (>= (vector-ref right-count i) time))
      (set! result (cons i result))))

  (reverse result))