(define (most-visited n rounds)
  (let* ([counts (make-vector n 0)]
         [first (car rounds)]
         [last (car (reverse rounds))]
         [_ (vector-set! counts (- first 1) (+ (vector-ref counts (- first 1)) 1))]
         [_ (for/list ([i (in-range 1 (length rounds))])
              (let ([start (list-ref rounds (- i 1))]
                    [end (list-ref rounds i)])
                (if (> end start)
                    (for ([j (in-range start end)])
                      (vector-set! counts (- j 1) (+ (vector-ref counts (- j 1)) 1)))
                    (begin
                      (for ([j (in-range start (+ n 1))])
                        (vector-set! counts (- j 1) (+ (vector-ref counts (- j 1)) 1)))
                      (for ([j (in-range 1 end)])
                        (vector-set! counts (- j 1) (+ (vector-ref counts (- j 1)) 1)))))))]
         [_ (vector-set! counts (- last 1) (+ (vector-ref counts (- last 1)) 1))]
         [max-count (apply max (vector->list counts))]
         [result (for/list ([i (in-range (vector-length counts))]
                              #:when (= (vector-ref counts i) max-count))
                   (+ i 1))])
    (sort result <)))