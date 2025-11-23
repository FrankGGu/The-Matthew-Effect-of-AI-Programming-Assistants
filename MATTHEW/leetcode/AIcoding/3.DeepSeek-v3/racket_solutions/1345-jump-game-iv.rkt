(define/contract (min-jumps arr)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([n (length arr)]
         [value-indices (make-hash)]
         [visited (make-hash)]
         [queue (make-queue)]
         [steps 0])
    (for ([i (in-range n)])
      (hash-update! value-indices (list-ref arr i) (lambda (v) (cons i v)) '()))
    (hash-set! visited 0 #t)
    (enqueue! queue 0)
    (let loop ()
      (if (queue-empty? queue)
          -1
          (let ([size (queue-length queue)])
            (for ([_ (in-range size)])
              (let ([current (dequeue! queue)])
                (if (= current (- n 1))
                    steps
                    (let ([next-indices (append (list (+ current 1) (- current 1))
                                               (hash-ref value-indices (list-ref arr current) '()))])
                      (for ([next next-indices])
                        (when (and (>= next 0) (< next n) (not (hash-ref visited next #f)))
                          (hash-set! visited next #t)
                          (enqueue! queue next)))
                      (hash-remove! value-indices (list-ref arr current))))))
            (set! steps (+ steps 1))
            (loop))))))