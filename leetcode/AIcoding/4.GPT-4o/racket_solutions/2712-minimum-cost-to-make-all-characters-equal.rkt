(define (minimumCost s)
  (define freq (make-vector 26 0))
  (for-each (lambda (c) (vector-set! freq (- (char->integer c) (char->integer #\a)) (+ 1 (vector-ref freq (- (char->integer c) (char->integer #\a))))) ) s)
  (define min-cost (apply + (vector->list freq)))
  (define max-freq (apply max (vector->list freq)))
  (- min-cost max-freq))

(minimumCost "abcde")