(define (semi-ordered-permutation nums)
  (let* ([n (length nums)]
         [pos1 (index-of nums 1)]
         [posn (index-of nums n)]
         [swaps (+ pos1 (- (- n 1) posn))])
    (if (> pos1 posn) (- swaps 1) swaps)))