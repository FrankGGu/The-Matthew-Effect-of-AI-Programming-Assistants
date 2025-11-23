(define/contract (minimum-mountain-removals nums)
  (-> (listof exact-integer?) exact-integer?)
  (define n (length nums))
  (define (lis nums)
    (let* ([n (length nums)]
           [dp (make-vector n 1)])
      (for ([i (in-range 1 n)])
        (for ([j (in-range i)])
          (when (and (< (list-ref nums j) (list-ref nums i))
            (vector-set! dp i (max (vector-ref dp i) (+ (vector-ref dp j) 1))))))
      dp))
  (let* ([left (lis nums)]
         [right (lis (reverse nums))]
         [right-rev (list->vector (reverse (vector->list right)))]
    (define max-mountain 0)
    (for ([i (in-range n)])
      (when (and (> (vector-ref left i) 1) (> (vector-ref right-rev i) 1))
        (set! max-mountain (max max-mountain (+ (vector-ref left i) (vector-ref right-rev i) -1)))))
    (- n max-mountain)))