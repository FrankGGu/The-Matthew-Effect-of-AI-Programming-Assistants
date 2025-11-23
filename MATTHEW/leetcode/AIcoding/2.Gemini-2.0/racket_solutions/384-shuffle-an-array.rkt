(define Solution%
  (class object%
    (init (nums))
    (super-new)

    (define/public original (list->vector nums))
    (define/public current (list->vector nums))

    (define/public reset
      (lambda ()
        (vector-copy! current 0 original 0 (vector-length original))
        (vector->list current)))

    (define/public shuffle
      (lambda ()
        (let loop ((i (- (vector-length current) 1)))
          (if (< i 1)
              (vector->list current)
              (let* ((j (random (+ i 1)))
                     (temp (vector-ref current i)))
                (vector-set! current i (vector-ref current j))
                (vector-set! current j temp)
                (loop (- i 1)))))))))