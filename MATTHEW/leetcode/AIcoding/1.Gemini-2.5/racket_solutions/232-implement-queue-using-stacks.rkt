(define (my-queue)
  (let ((s1 '()) ; input stack
        (s2 '())) ; output stack

    (define (transfer-s1-to-s2!)
      (when (empty? s2)
        (let loop ()
          (when (not (empty? s1))
            (set! s2 (cons (car s1) s2))
            (set! s1 (cdr s1))
            (loop)))))

    (define (push! x)
      (set! s1 (cons x s1)))

    (define (pop!)
      (transfer-s1-to-s2!)
      (let ((val (car s2)))
        (set! s2 (cdr s2))
        val))

    (define (peek!)
      (transfer-s1-to-s2!)
      (car s2))

    (define (empty?)
      (and (empty? s1) (empty? s2)))

    (lambda (method . args)
      (case method
        ((push) (apply push! args))
        ((pop) (pop!))
        ((peek) (peek!))
        ((empty) (empty?))
        (else (error "Unknown method" method))))))