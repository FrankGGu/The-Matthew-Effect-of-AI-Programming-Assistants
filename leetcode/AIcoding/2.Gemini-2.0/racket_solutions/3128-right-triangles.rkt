(define (solve points)
  (let ([n (length points)])
    (let loop ([i 0] [count 0])
      (if (= i n)
          count
          (let* ([p1 (list-ref points i)]
                 [x1 (car p1)]
                 [y1 (cadr p1)]
                 [x-set (make-hash)]
                 [y-set (make-hash)])
            (for ([j (in-range n)])
              (when (not (= i j))
                (let ([p2 (list-ref points j)]
                      [x2 (car p2)]
                      [y2 (cadr p2)])
                  (when (= x1 x2)
                    (hash-set! x-set y2 #t))
                  (when (= y1 y2)
                    (hash-set! y-set x2 #t)))))
            (let ([x-count (hash-count x-set)]
                  [y-count (hash-count y-set)])
              (loop (+ i 1) (+ count (* x-count y-count)))))))))