(define/contract (number-of-substrings s)
  (-> string? exact-integer?)
  (define n (string-length s))
  (define (char->idx c) (- (char->integer c) (char->integer #\a)))
  (let loop ([left 0] [right 0] [count 0] [freq (make-vector 3 0)])
    (cond
      [(= right n) count]
      [else
       (define c (char->idx (string-ref s right)))
       (vector-set! freq c (add1 (vector-ref freq c)))
       (let ([new-count count])
         (let inner ([left left] [freq freq])
           (if (and (< left n) (andmap (lambda (x) (> x 0)) (vector->list freq))
               (let ([c-left (char->idx (string-ref s left))])
                 (vector-set! freq c-left (sub1 (vector-ref freq c-left)))
                 (inner (add1 left) freq)
                 (set! new-count (+ new-count (- n right)))))
               (loop left (add1 right) new-count freq))))])))