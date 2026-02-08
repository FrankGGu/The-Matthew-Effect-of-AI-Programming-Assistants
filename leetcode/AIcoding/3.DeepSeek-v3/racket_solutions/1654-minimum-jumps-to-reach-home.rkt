(define (minimum-jumps forbidden a b x)
  (let* ([max-limit (+ x b (* 2 (apply max (cons a (cons b forbidden))))]
         [visited (make-hash)]
         [forbidden-set (list->set forbidden)])
    (define (bfs)
      (let ([queue (make-queue)]
            [steps 0])
        (enqueue! queue (cons 0 #t))
        (hash-set! visited (cons 0 #t) #t)
        (let loop ()
          (if (queue-empty? queue)
              -1
              (let ([size (queue-length queue)])
                (let inner-loop ([i 0])
                  (if (= i size)
                      (begin
                        (set! steps (add1 steps))
                        (loop))
                      (let* ([current (dequeue! queue)]
                             [pos (car current)]
                             [can-back (cdr current)])
                        (if (= pos x)
                            steps
                            (let ([next-pos (+ pos a)])
                              (when (and (<= next-pos max-limit)
                                        (not (set-member? forbidden-set next-pos))
                                        (not (hash-has-key? visited (cons next-pos #t))))
                                (hash-set! visited (cons next-pos #t) #t)
                                (enqueue! queue (cons next-pos #t)))
                              (when (and can-back (>= (- pos b) 0))
                                (let ([back-pos (- pos b)])
                                  (when (and (not (set-member? forbidden-set back-pos))
                                            (not (hash-has-key? visited (cons back-pos #f))))
                                    (hash-set! visited (cons back-pos #f) #t)
                                    (enqueue! queue (cons back-pos #f)))))
                              (inner-loop (add1 i)))))))))))
    (bfs)))