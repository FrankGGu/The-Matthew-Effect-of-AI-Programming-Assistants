(define (grid-game grid)
  (let* ([row0-list (car grid)]
         [row1-list (cadr grid)]
         [n (length row0-list)])

    (define row0 (list->vector row0-list))
    (define row1 (list->vector row1-list))

    (define s0 (make-vector (+ n 1) 0))
    (for ([i (range (- n 1) -1 -1)])
      (vector-set! s0 i (+ (vector-ref row0 i) (vector-ref s0 (+ i 1)))))

    (define p1 (make-vector (+ n 1) 0))
    (for ([i (range n)])
      (vector-set! p1 (+ i 1) (+ (vector-ref row1 i) (vector-ref p1 i))))

    (let loop ([i 0] [min-robot2-score +inf.0])
      (if (= i n)
          min-robot2-score
          (let* ([robot2-top-path (vector-ref s0 (+ i 1))]
                 [robot2-bottom-path (vector-ref p1 i)]
                 [current-robot2-score (max robot2-top-path robot2-bottom-path)])
            (loop (+ i 1) (min min-robot2-score current-robot2-score)))))))