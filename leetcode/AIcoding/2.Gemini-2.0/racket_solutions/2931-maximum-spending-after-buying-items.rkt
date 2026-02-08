(define (maximum-spending items)
  (let* ([n (vector-length items)]
         [m (vector-length (vector-ref items 0))])
    (let loop ([costs (list)]
               [i 0])
      (if (= i n)
          (apply + 0 costs)
          (let* ([max-cost (apply max (vector-ref items i))]
                 [index (vector-index (vector-ref items i) max-cost)])
            (vector-set! (vector-ref items i) index -1)
            (loop (cons max-cost costs) (+ i 1)))))))

(define (vector-index vec val)
  (let loop ([i 0])
    (cond
      [(= i (vector-length vec)) #f]
      [(= (vector-ref vec i) val) i]
      [else (loop (+ i 1))])))

(define (solve items)
  (let* ([n (length items)]
         [m (length (car items))]
         [items-vector (make-vector n)])
    (for ([i (in-range n)])
      (let ([row (list->vector (list-sort > (car (list-ref items i)) <))])
        (vector-set! items-vector i row)))

    (let loop ([spending 0]
               [k (- m 1)])
      (if (< k 0)
          spending
          (let* ([max-val #f]
                 [max-index #f])
            (for ([i (in-range n)])
              (when (>= (vector-length (vector-ref items-vector i)) (+ k 1))
                (let ([current-val (vector-ref (vector-ref items-vector i) k)])
                  (when (or (not max-val) (> current-val max-val))
                    (set! max-val current-val)
                    (set! max-index i)))))
            (loop (+ spending (* (+ k 1) max-val)) k))))))