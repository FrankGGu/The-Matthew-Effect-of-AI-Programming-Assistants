(define (smallest-unoccupied-chair seats target)
  (let* ([n (length seats)]
         [arrival-times (make-vector n)]
         [leaving-times (make-vector n)]
         [target-arrival (vector-ref (vector (apply min seats)) 0)]
         [target-leaving (vector-ref (vector (apply max seats)) 1)])
    (for ([i (in-range n)])
      (vector-set! arrival-times i (vector-ref (vector-ref seats i) 0))
      (vector-set! leaving-times i (vector-ref (vector-ref seats i) 1)))

    (let loop ([available-chairs (list)]
               [occupied-chairs (list)]
               [events (sort (append (map (lambda (i) (list (vector-ref arrival-times i) 0 i)) (range n))
                                     (map (lambda (i) (list (vector-ref leaving-times i) 1 i)) (range n)))
                             < #:key car)]
               [chair-map (make-hash)])
      (cond
        [(null? events) #f]
        [else
         (let* ([event (car events)]
                [time (car event)]
                [type (cadr event)]
                [index (caddr event)])
           (cond
             [(= type 0) ; arrival
              (let* ([chair (cond
                              [(null? available-chairs)
                               (if (null? occupied-chairs)
                                   0
                                   (+ 1 (apply max occupied-chairs))))
                               [else (car available-chairs)])])
                (hash-set! chair-map index chair)
                (if (= (vector-ref (vector-ref seats target) 0) time)
                    chair
                    (loop (cdr available-chairs) (cons chair occupied-chairs) (cdr events) chair-map)))]
             [(= type 1) ; leaving
              (let ([chair (hash-ref chair-map index)])
                (loop (sort (cons chair available-chairs) <) (remove chair occupied-chairs) (cdr events) chair-map))]
             [else #f]))])))))