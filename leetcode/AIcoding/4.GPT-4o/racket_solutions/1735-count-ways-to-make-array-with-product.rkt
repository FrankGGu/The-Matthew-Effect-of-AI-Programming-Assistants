(define (count-ways nums)
  (define mod 1000000007)
  (define n (length nums))
  (define dp (make-vector (+ n 1) 0))
  (vector-set! dp 0 1)

  (for ([i (in-range 1 (+ n 1))])
    (for ([j (in-range i)])
      (let ([product (apply * (subvector nums j i))])
        (when (and (= product (apply * (subvector nums j i))) (> product 0))
          (vector-set! dp i (mod (+ (vector-ref dp i) (vector-ref dp j)) mod))))))

  (vector-ref dp n))

(define (count-ways-to-make-array-with-product nums)
  (count-ways nums))