(define circular-queue%
  (class object%
    (init-field capacity)
    (super-new)
    (define queue (make-vector capacity #f))
    (define front 0)
    (define rear -1)
    (define size 0)

    (define/public (en-queue value)
      (if (is-full?)
          #f
          (begin
            (set! rear (modulo (+ rear 1) capacity))
            (vector-set! queue rear value)
            (set! size (+ size 1))
            #t)))

    (define/public (de-queue)
      (if (is-empty?)
          #f
          (begin
            (vector-set! queue front #f)
            (set! front (modulo (+ front 1) capacity))
            (set! size (- size 1))
            #t)))

    (define/public (front-element)
      (if (is-empty?)
          -1
          (vector-ref queue front)))

    (define/public (rear-element)
      (if (is-empty?)
          -1
          (vector-ref queue rear)))

    (define/public (is-empty?)
      (= size 0))

    (define/public (is-full?)
      (= size capacity))))