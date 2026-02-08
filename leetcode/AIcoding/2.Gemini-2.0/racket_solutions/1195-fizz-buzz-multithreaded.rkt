(define (fizz-buzz n)
  (define (fizz-buzz-multithreaded n threads)
    (define (make-channel) (make-channel))
    (define (send ch v) (channel-put ch v))
    (define (recv ch) (channel-get ch))

    (define fizz-channel (make-channel))
    (define buzz-channel (make-channel))
    (define fizzbuzz-channel (make-channel))
    (define number-channel (make-channel))
    (define output-channel (make-channel))

    (define (fizz)
      (for ([i (in-range 1 (+ n 1))])
        (when (= (modulo i 3) 0)
          (send fizz-channel i))))

    (define (buzz)
      (for ([i (in-range 1 (+ n 1))])
        (when (= (modulo i 5) 0)
          (send buzz-channel i))))

    (define (fizzbuzz)
      (for ([i (in-range 1 (+ n 1))])
        (when (and (= (modulo i 3) 0) (= (modulo i 5) 0))
          (send fizzbuzz-channel i))))

    (define (number)
      (for ([i (in-range 1 (+ n 1))])
        (unless (or (= (modulo i 3) 0) (= (modulo i 5) 0))
          (send number-channel i))))

    (define (output)
      (for ([i (in-range 1 (+ n 1))])
        (cond
          [(channel-try-get fizzbuzz-channel) => (lambda (x) (send output-channel "FizzBuzz"))]
          [(channel-try-get fizz-channel) => (lambda (x) (send output-channel "Fizz"))]
          [(channel-try-get buzz-channel) => (lambda (x) (send output-channel "Buzz"))]
          [(channel-try-get number-channel) => (lambda (x) (send output-channel (number->string x)))]
          [else (begin (sleep 0.001) (send output-channel #f))]
          )
        ))

    (define (collect-output)
      (define result '())
      (for ([i (in-range 1 (+ n 1))])
        (let loop ()
          (define val (recv output-channel))
          (if (equal? val #f)
              (loop)
              (set! result (append result (list val))))
          ))
      result)

    (define fizz-future (future fizz))
    (define buzz-future (future buzz))
    (define fizzbuzz-future (future fizzbuzz))
    (define number-future (future number))
    (define output-future (future output))

    (define output-list (collect-output))

    (touch fizz-future)
    (touch buzz-future)
    (touch fizzbuzz-future)
    (touch number-future)
    (touch output-future)

    output-list)

  (fizz-buzz-multithreaded n 4))