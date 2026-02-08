(define (countSpecialSubsequences nums)
  (define n (length nums))
  (define mod 1000000007)
  (define dp (make-vector (+ n 1) 0))
  (define count-0 0)
  (define count-1 0)
  (define count-2 0)

  (for ([i (in-range n)])
    (define current (vector-ref nums i))
    (cond
      [(= current 0)
       (set! count-0 (mod (+ count-0 count-1) mod))
       (set! count-1 (mod (+ count-1 count-1) mod))
       (set! count-2 (mod (+ count-2 count-2) mod))]
      [(= current 1)
       (set! count-1 (mod (+ count-1 count-0) mod))
       (set! count-2 (mod (+ count-2 count-2) mod))]
      [(= current 2)
       (set! count-2 (mod (+ count-2 count-1) mod))]))

  (mod (+ count-0 count-1 count-2) mod))

(define (numSpecialSubseq nums)
  (countSpecialSubsequences nums))