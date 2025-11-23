(define (find-maximum-length nums)
  (define freq (make-hash))
  (for ([num (in-list nums)])
    (hash-set! freq num (+ (hash-ref freq num 0) 1)))

  (define unique-nums (hash-keys freq))

  (define max-len 0)

  (for ([x (in-list unique-nums)])
    (for ([y (in-list unique-nums)])
      (when (not (= x y))
        (define count-x (hash-ref freq x))
        (define count-y (hash-ref freq y))
        (define current-len (* 2 (min count-x count-y)))
        (set! max-len (max max-len current-len)))))

  max-len)