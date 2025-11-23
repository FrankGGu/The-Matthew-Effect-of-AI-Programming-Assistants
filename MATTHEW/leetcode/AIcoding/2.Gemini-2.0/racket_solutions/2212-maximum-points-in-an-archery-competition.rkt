(define (maximum-points aliceArrows numArrows target)
  (let* ([n (length target)]
         (max-score 0)
         (best-arrows (make-vector n 0)))
    (letrec ([solve (lambda (idx remaining arrows score)
                       (if (= idx n)
                           (if (> score max-score)
                               (begin
                                 (set! max-score score)
                                 (vector-copy! best-arrows 0 arrows 0 n))
                               #f)
                           (begin
                             ; Don't win the point
                             (solve (+ idx 1) remaining arrows score)
                             ; Try to win the point
                             (let ([needed (+ (vector-ref target idx) 1)])
                               (if (>= remaining needed)
                                   (begin
                                     (vector-set! arrows idx needed)
                                     (solve (+ idx 1) (- remaining needed) arrows (+ score (- n idx 1)))
                                     (vector-set! arrows idx 0)) ; Backtrack
                                   #f)))))]
             [fill-remaining (lambda (remaining)
                               (for ([i (in-range n)])
                                 (when (= (vector-ref best-arrows i) 0)
                                   (let ([fill-amount (min remaining 1)])
                                     (vector-set! best-arrows 0 (+ (vector-ref best-arrows 0) fill-amount))
                                     (set! remaining (- remaining fill-amount))))))])
      (solve 0 numArrows (make-vector n 0) 0)
      (fill-remaining (- numArrows (vector-sum best-arrows)))
      (vector->list best-arrows))))

(define (vector-sum vec)
  (for/sum ([i (in-range (vector-length vec))])
    (vector-ref vec i)))