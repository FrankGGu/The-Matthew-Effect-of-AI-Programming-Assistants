(define (find-losers n k)
  (let* ((winners (make-vector n #f))
         (current-player 0)
         (multiplier 1))

    (let loop ()
      (if (vector-ref winners current-player)
          (void)
          (vector-set! winners current-player #t)))

    (let next-player ()
      (set! current-player (modulo (+ current-player (* k multiplier)) n))
      (set! multiplier (+ 1 multiplier))

      (if (not (vector-ref winners current-player))
          (loop)
          (void)))

    (loop)

    (let ((losers '()))
      (for/list ((i (in-range n)))
        (if (not (vector-ref winners i))
            (+ 1 i)
            #f))
      (filter number? (for/list ((i (in-range n)))
                           (if (not (vector-ref winners i))
                               (+ 1 i)
                               #f)))))