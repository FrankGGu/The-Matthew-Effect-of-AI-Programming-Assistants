(define (make-memory-allocator n)
  (let ([memory (make-vector n #f)]
        [used-blocks (hash)])
    (define (allocate size mID)
      (let loop ([i 0])
        (cond
          [(>= i (- n size -1)) -1]
          [(let loop2 ([j 0])
             (cond
               [(>= j size) #t]
               [(not (equal? (vector-ref memory (+ i j)) #f)) #f]
               [else (loop2 (+ j 1))]))
           (begin
             (for ([k (in-range size)])
               (vector-set! memory (+ i k) mID))
             (hash-set! used-blocks mID (list i size))
             i)]
          [else (loop (+ i 1))])))
    (define (free mID)
      (cond
        [(hash-has-key? used-blocks mID)
         (let* ([block (hash-ref used-blocks mID)]
                [start (car block)]
                [size (cadr block)])
           (for ([i (in-range start (+ start size))])
             (vector-set! memory i #f))
           (hash-remove! used-blocks mID)
           #t)]
        [else #f]))
    (define (reallocate mID size)
      (cond
        [(hash-has-key? used-blocks mID)
         (let* ([block (hash-ref used-blocks mID)]
                [start (car block)]
                [old-size (cadr block)])
           (free mID)
           (let ([new-start (allocate size mID)])
             (cond
               [(equal? new-start -1) -1]
               [else
                (for ([i (in-range old-size)])
                  (vector-set! memory (+ new-start i) mID))
                new-start])))]
        [else -1]))

    (lambda (method . args)
      (case method
        [(allocate) (apply allocate args)]
        [(free) (apply free args)]
        [(reallocate) (apply reallocate args)]
        [else (error "Invalid method")]))))