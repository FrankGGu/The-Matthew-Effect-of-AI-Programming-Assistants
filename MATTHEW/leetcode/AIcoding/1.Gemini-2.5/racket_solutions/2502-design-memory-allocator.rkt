(define (MAllocator total-size)
  (define memory (make-vector total-size 0))

  (define (allocate mID block-size)
    (let loop-outer ((i 0))
      (cond
        ((>= i total-size) -1)
        (else
         (let loop-inner ((j i) (current-free-count 0))
           (cond
             ((= current-free-count block-size)
              (for ((k (in-range i (+ i block-size))))
                (vector-set! memory k mID))
              i)
             ((>= j total-size)
              (loop-outer (+ i 1)))
             ((zero? (vector-ref memory j))
              (loop-inner (+ j 1) (+ current-free-count 1)))
             (else
              (loop-outer (+ j 1))))))))

  (define (free mID)
    (let loop ((i 0) (freed-count 0))
      (cond
        ((>= i total-size) freed-count)
        (else
         (if (= (vector-ref memory i) mID)
             (begin
               (vector-set! memory i 0)
               (loop (+ i 1) (+ freed-count 1)))
             (loop (+ i 1) freed-count))))))

  (lambda (msg . args)
    (case msg
      ((allocate) (apply allocate args))
      ((free) (apply free args))
      (else (error "MAllocator: Unknown message" msg)))))