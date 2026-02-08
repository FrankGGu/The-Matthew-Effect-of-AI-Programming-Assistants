(define (count-k-subsequences s k)
  (define freq (make-hash))
  (for ([c (in-string s)])
    (hash-update! freq c add1 0))
  (define freq-list (sort (hash-values freq) >))
  (if (< (length freq-list) k)
      0
      (let* ([max-beauty (apply + (take freq-list k))]
             [min-freq (list-ref freq-list (sub1 k))]
             [count-min (count (lambda (x) (= x min-freq)) freq-list)]
             [selected (count (lambda (x) (> x min-freq)) (take freq-list k))])
        (modulo (binomial count-min (- k selected)) 1000000007))))

(define (binomial n k)
  (if (or (< k 0) (> k n))
      0
      (let loop ([i 1] [res 1])
        (if (> i k)
            res
            (loop (add1 i) (quotient (* res (- n i -1)) i)))))