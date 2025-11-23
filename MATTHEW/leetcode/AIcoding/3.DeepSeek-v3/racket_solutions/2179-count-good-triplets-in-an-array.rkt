(define (good-triplets nums1 nums2)
  (define n (length nums1))
  (define pos2 (make-hash))
  (for ([num nums2] [i (in-naturals)])
    (hash-set! pos2 num i))

  (define nums (list->vector (map (lambda (x) (hash-ref pos2 x)) nums1))

  (define (query bit i)
    (let loop ([sum 0] [i i])
      (if (<= i 0)
          sum
          (loop (+ sum (vector-ref bit i)) (- i (bitwise-and i (- i)))))))

  (define (update bit i delta)
    (let loop ([i i])
      (when (<= i n)
        (vector-set! bit i (+ (vector-ref bit i) delta))
        (loop (+ i (bitwise-and i (- i)))))))

  (define left (make-vector (+ n 1) 0))
  (define right (make-vector (+ n 1) 0))

  (define res 0)

  (for ([i (in-range n)])
    (define num (vector-ref nums i))
    (define l (query left (- num 1)))
    (update left num 1)
    (define r (- (query right n) (query right num)))
    (update right num 1)
    (set! res (+ res (* l r)))

  res)