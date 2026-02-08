(define (k-similarity s1 s2)
  (define (swap s i j)
    (let* ([vec (list->vector (string->list s))]
           [tmp (vector-ref vec i)])
      (vector-set! vec i (vector-ref vec j))
      (vector-set! vec j tmp)
      (list->string (vector->list vec))))

  (define (bfs)
    (let ([queue (make-queue)]
          [visited (make-hash)])
      (enqueue! queue (cons s1 0))
      (hash-set! visited s1 #t)
      (let loop ()
        (if (queue-empty? queue)
            0
            (let* ([current (dequeue! queue)]
                   [current-s (car current)]
                   [current-k (cdr current)]
                   [i (let find ([i 0])
                        (if (or (>= i (string-length current-s))
                                (not (char=? (string-ref current-s i) (string-ref s2 i))))
                            i
                            (find (add1 i))))])
              (if (>= i (string-length current-s))
                  current-k
                  (let ([result (let loop2 ([j (add1 i)])
                                  (if (>= j (string-length current-s))
                                      #f
                                      (if (and (char=? (string-ref current-s j) (string-ref s2 i))
                                          (let ([next-s (swap current-s i j)])
                                            (if (hash-has-key? visited next-s)
                                                (loop2 (add1 j))
                                                (begin
                                                  (hash-set! visited next-s #t)
                                                  (enqueue! queue (cons next-s (add1 current-k)))
                                                  (loop2 (add1 j)))))
                                          (loop2 (add1 j)))))])
                    (if result
                        (loop)
                        (loop)))))))))

  (bfs))