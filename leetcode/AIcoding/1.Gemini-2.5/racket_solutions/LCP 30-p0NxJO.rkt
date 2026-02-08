#lang racket

(require data/heap)

(define (min-operations nums)
  (let* ([n (length nums)]
         [total-sum (apply + nums)])

    (if (< total-sum 0)
        -1
        (let ([nums-vec (list->vector nums)])
          (let loop ([i 0]
                     [current-health 1]
                     [operations 0]
                     [pq (make-heap >)])
            (if (= i n)
                operations
                (let* ([x (vector-ref nums-vec i)]
                       [new-health (+ current-health x)])
                  (cond
                    [(> x 0)
                     (loop (+ i 1) new-health operations pq)]
                    [else ; x <= 0
                     (heap-add! pq x)
                     (let loop-recover ([current-h new-health]
                                        [ops operations]
                                        [current-pq pq])
                       (if (> current-h 0)
                           (loop (+ i 1) current-h ops current-pq)
                           (let* ([m (heap-max current-pq)]
                                  [updated-pq (heap-remove-max! current-pq)])
                             (loop-recover (- current-h m) (+ ops 1) updated-pq)))))])))))))