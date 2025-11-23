(define (max-width-ramp nums)
  (let* ([n (length nums)]
         [indexed-nums (for/list ([val nums] [idx (range n)])
                         (list val idx))]
         [sorted-indexed-nums (sort indexed-nums (lambda (a b) (< (car a) (car b))))])

    (if (zero? n)
        0
        (for/fold ([max-width 0]
                   [min-idx-so-far n]) ; Initialize min-idx-so-far to a value larger than any possible index
                  ([item sorted-indexed-nums])
          (let ([current-idx (cadr item)])
            (values (max max-width (- current-idx min-idx-so-far))
                    (min min-idx-so-far current-idx)))))))