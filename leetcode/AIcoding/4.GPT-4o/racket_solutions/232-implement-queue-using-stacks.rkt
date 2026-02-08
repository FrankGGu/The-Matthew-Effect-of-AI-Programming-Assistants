(define Queue
  (class object%
    (super-new)
    (define/override (initialize)
      (set! in-stack (new (list)))
      (set! out-stack (new (list))))
    (define in-stack (new (list)))
    (define out-stack (new (list)))

    (define (push x)
      (send in-stack add x))

    (define (pop)
      (when (send out-stack is-empty)
        (while (not (send in-stack is-empty))
          (send out-stack add (send in-stack remove))))
      (send out-stack remove))

    (define (peek)
      (when (send out-stack is-empty)
        (while (not (send in-stack is-empty))
          (send out-stack add (send in-stack remove))))
      (send out-stack peek))

    (define (empty)
      (and (send in-stack is-empty) (send out-stack is-empty)))

    (public (push) push)
    (public (pop) pop)
    (public (peek) peek)
    (public (empty) empty)))