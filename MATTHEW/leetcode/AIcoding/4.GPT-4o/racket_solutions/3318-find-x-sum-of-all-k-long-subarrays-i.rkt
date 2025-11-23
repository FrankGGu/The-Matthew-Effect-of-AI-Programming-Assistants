(define (xSum arr k)
  (define (sum-subarray start)
    (if (< start (+ (length arr) 1 - k))
        (+ (apply + (sublist arr start (+ start k)))
           (sum-subarray (+ start 1)))
        0))
  (sum-subarray 0))

(define (findXSum arr k)
  (if (<= k 0)
      0
      (xSum arr k)))