(define (k-items-with-maximum-sum numOnes numZeros numNegOnes k)
  (cond
    [(<= k numOnes) k]
    [(<= k (+ numOnes numZeros)) numOnes]
    [else (- numOnes (- k (+ numOnes numZeros)))]))