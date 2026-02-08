(define (meeting-rooms-iii n meetings)
  (let* ([rooms (make-vector n 0)]
         [available-rooms (for/list ([i (in-range n)]) i)]
         [events (sort meetings (lambda (x y) (< (first x) (first y))))])
    (for ([meeting (in-list events)])
      (let ([start (first meeting)]
            [end (second meeting)])
        (let loop ([used-rooms (sort (filter (lambda (x) (> (vector-ref rooms x) start)) (sequence->list (in-range n))) <)]
                   [available-rooms (sort (filter (lambda (x) (not (member x used-rooms))) (sequence->list (in-range n))) <)])
          (cond
            [(empty? available-rooms)
             (let* ([earliest-room (argmin (lambda (x) (vector-ref rooms x)) used-rooms)]
                    [release-time (vector-ref rooms earliest-room)])
               (vector-set! rooms earliest-room (+ end (- release-time start)))))
            (else
             (let ([room (first available-rooms)])
               (vector-set! rooms room end))))))))
    (argmax (lambda (x) (vector-ref rooms x)) (sequence->list (in-range n)))))