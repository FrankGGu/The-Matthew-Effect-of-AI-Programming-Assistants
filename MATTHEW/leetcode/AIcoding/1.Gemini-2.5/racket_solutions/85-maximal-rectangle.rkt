(define (maximal-rectangle matrix)
  (let* ([rows (length matrix)]
         [cols (if (null? matrix) 0 (length (car matrix)))])
    (if (zero? rows)
        0
        (let ([heights (make-vector cols 0)])
          (let loop-rows ([r 0] [max-area 0])
            (if (= r rows)
                max-area
                (begin
                  (for ([c (in-range cols)])
                    (if (char=? (list-ref (list-ref matrix r) c) #\1)
                        (vector-set! heights c (+ (vector-ref heights c) 1))
                        (vector-set! heights c 0)))
                  (let ([current-max-area (largest-rectangle-in-histogram heights)])
                    (loop-rows (+ r 1) (max max-area current-max-area))))))))))

(define (largest-rectangle-in-histogram heights-vec)
  (let* ([n (vector-length heights-vec)])
    (let loop ([i 0] [stack '()] [max-area 0])
      (if (> i n)
          max-area
          (let* ([h (if (= i n) 0 (vector-ref heights-vec i))])
            (let inner-loop-pop ([s stack] [ma max-area])
              (if (and (not (null? s))
                       (>= (vector-ref heights-vec (car s)) h))
                  (let* ([top-idx (car s)]
                         [top-h (vector-ref heights-vec top-idx)]
                         [prev-s (cdr s)]
                         [width (if (null? prev-s) i (- i (car prev-s) 1))]
                         [new-ma (max ma (* top-h width))])
                    (inner-loop-pop prev-s new-ma))
                  (loop (+ i 1) (cons i s) ma))))))))