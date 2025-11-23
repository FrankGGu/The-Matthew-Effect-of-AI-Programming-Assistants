(define/contract (car-fleet target position speed)
  (-> exact-integer? (listof exact-integer?) (listof exact-integer?) exact-integer?)
  (let* ([cars (sort (map cons position speed) > #:key car)]
         [stack '()]
         [push (lambda (time)
                 (let loop ([s stack])
                   (if (or (null? s) (> time (car s)))
                       (set! stack (cons time stack))
                       (loop (cdr s)))))])
    (for ([car cars])
      (let ([pos (car car)]
            [spd (cdr car)])
        (push (/ (- target pos) spd))))
    (length stack)))