(define (count-subarrays nums k)
  (let* ([n (length nums)]
         [pos (index-of nums k)]
         [balance 0]
         [count (make-hash)]
         [result 0])
    (hash-set! count 0 1)
    (for ([i (in-range pos)])
      (set! balance (+ balance (if (> (list-ref nums i) k) 1 -1)))
      (hash-set! count balance (+ (hash-ref count balance 0) 1)))
    (set! balance 0)
    (for ([i (in-range pos n)])
      (set! balance (+ balance (if (> (list-ref nums i) k) 1 -1)))
      (set! result (+ result (hash-ref count (- 0 balance) 0)))
      (set! result (+ result (hash-ref count (- 1 balance) 0))))
    result))