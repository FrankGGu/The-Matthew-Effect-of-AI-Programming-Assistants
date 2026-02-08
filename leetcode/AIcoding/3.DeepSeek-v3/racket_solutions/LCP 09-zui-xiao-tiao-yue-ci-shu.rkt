(define/contract (min-jump jump)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([n (length jump)]
         [visited (make-vector n #f)]
         [q (make-queue)])
    (enqueue! q 0)
    (vector-set! visited 0 #t)
    (let loop ([steps 0])
      (if (queue-empty? q)
          -1
          (let ([size (queue-length q)])
            (for ([_ (in-range size)])
              (let ([i (dequeue! q)])
                (if (>= (+ i (list-ref jump i)) n)
                    (add1 steps)
                    (begin
                      (unless (vector-ref visited (+ i (list-ref jump i)))
                        (vector-set! visited (+ i (list-ref jump i)) #t)
                        (enqueue! q (+ i (list-ref jump i))))
                      (for ([j (in-range 0 i)])
                        (unless (vector-ref visited j)
                          (vector-set! visited j #t)
                          (enqueue! q j)))
                      (loop (add1 steps))))))))))