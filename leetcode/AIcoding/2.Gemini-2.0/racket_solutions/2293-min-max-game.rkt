(define (min-max-game nums)
  (if (empty? nums)
      0
      (let loop ([nums nums])
        (if (= (length nums) 1)
            (first nums)
            (let* ([n (length nums)]
                   [new-nums (make-vector (/ n 2))])
              (for ([i (in-range 0 (/ n 2))])
                (if (even? i)
                    (vector-set! new-nums i (min (list (vector-ref nums (* 2 i)) (vector-ref nums (+ 1 (* 2 i))))))
                    (vector-set! new-nums i (max (list (vector-ref nums (* 2 i)) (vector-ref nums (+ 1 (* 2 i))))))))
              (loop (list->vector (vector->list new-nums))))))))