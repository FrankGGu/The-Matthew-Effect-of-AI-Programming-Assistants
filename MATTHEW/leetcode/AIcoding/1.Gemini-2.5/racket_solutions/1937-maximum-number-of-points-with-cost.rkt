#lang racket

(define (max-points points)
  (let* ([m (length points)]
         [n (length (car points))])

    (if (= m 0)
        0
        (let loop ([row-idx 0]
                   [prev-dp (list->vector (car points))])

          (if (= row-idx (- m 1))
              (apply max (vector->list prev-dp))
              (let* ([current-row-list (list-ref points (+ row-idx 1))]
                     [current-row (list->vector current-row-list)]

                     [max-left-values
                      (let ([ml-vec (make-vector n 0)])
                        (vector-set! ml-vec 0 (+ (vector-ref prev-dp 0) 0))
                        (for ([j (in-range 1 n)])
                          (vector-set! ml-vec j
                                       (max (vector-ref ml-vec (- j 1))
                                            (+ (vector-ref prev-dp j) j))))
                        ml-vec)]

                     [max-right-values
                      (let ([mr-vec (make-vector n 0)])
                        (vector-set! mr-vec (- n 1) (- (vector-ref prev-dp (- n 1)) (- n 1)))
                        (for ([j (in-range (- n 2) -1 -1)])
                          (vector-set! mr-vec j
                                       (max (vector-ref mr-vec (+ j 1))
                                            (- (vector-ref prev-dp j) j))))
                        mr-vec)]

                     [next-dp (let ([nd-vec (make-vector n 0)])
                                (for ([j (in-range n)])
                                  (let ([cost-left (- (vector-ref max-left-values j) j)]
                                        [cost-right (+ (vector-ref max-right-values j) j)])
                                    (vector-set! nd-vec j
                                                 (+ (vector-ref current-row j) (max cost-left cost-right)))))
                                nd-vec)])

                (loop (+ row-idx 1) next-dp)))))))