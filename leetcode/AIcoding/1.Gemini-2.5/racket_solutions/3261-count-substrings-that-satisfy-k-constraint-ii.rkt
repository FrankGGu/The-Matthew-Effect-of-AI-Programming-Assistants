(define (count-substrings-that-satisfy-k-constraint-ii s k)
  (let* ((n (string-length s))
         (sum-counts (make-hash))
         (current-sum 0)
         (result 0))

    (hash-set! sum-counts 0 1)

    (for ([i (in-range n)])
      (let* ((char-val (+ (- (char->integer (string-ref s i))
                             (char->integer #\a))
                          1)))
        (set! current-sum (+ current-sum char-val))
        (let ((target-sum (- current-sum k)))
          (when (hash-has-key? sum-counts target-sum)
            (set! result (+ result (hash-ref sum-counts target-sum)))))
        (hash-set! sum-counts current-sum
                   (+ (hash-ref sum-counts current-sum 0) 1))))
    result))