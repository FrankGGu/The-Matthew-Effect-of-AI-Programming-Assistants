(struct data-stream (value k count) #:mutable)

(define (data-stream-init value k)
  (data-stream value k 0))

(define (data-stream-consec ds num)
  (let ([target-value (data-stream-value ds)]
        [required-k (data-stream-k ds)])
    (if (= num target-value)
        (set-data-stream-count! ds (+ (data-stream-count ds) 1))
        (set-data-stream-count! ds 0)))
  (>= (data-stream-count ds) (data-stream-k ds)))