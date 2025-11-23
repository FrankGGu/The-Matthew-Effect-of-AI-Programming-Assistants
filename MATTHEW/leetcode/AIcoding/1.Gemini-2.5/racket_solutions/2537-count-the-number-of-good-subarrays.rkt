(define (count-good-subarrays nums k)
  (define (count-at-most k-val)
    (define n (vector-length nums))
    (define ans 0)
    (define left 0)
    (define current-pairs 0)
    (define freq (make-hash))

    (for ([right (in-range n)])
      (define num-r (vector-ref nums right))
      (set! current-pairs (+ current-pairs (hash-ref freq num-r 0)))
      (hash-set! freq num-r (+ (hash-ref freq num-r 0) 1))

      (while (> current-pairs k-val)
        (define num-l (vector-ref nums left))
        (hash-set! freq num-l (- (hash-ref freq num-l) 1))
        (set! current-pairs (- current-pairs (hash-ref freq num-l)))
        (set! left (+ left 1)))

      (set! ans (+ ans (- right left -1))))
    ans)

  (- (count-at-most k) (count-at-most (- k 1))))