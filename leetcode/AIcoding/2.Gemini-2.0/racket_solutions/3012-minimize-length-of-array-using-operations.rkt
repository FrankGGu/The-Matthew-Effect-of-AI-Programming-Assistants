(define (minimum-array-length nums)
  (let* ([n (length nums)]
         [freq (make-hash)]
         [max-freq 0])
    (for ([num (in-list nums)])
      (hash-update! freq num (λ (v) (+ v 1)) 1)
      (set! max-freq (max max-freq (hash-ref freq num))))
    (if (> (* 2 max-freq) n)
        (- (* 2 max-freq) n)
        (if (even? n) 0 1))))