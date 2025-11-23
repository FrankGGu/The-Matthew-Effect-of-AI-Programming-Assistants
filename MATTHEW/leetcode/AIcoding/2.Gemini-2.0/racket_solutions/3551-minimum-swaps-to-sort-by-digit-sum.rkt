(define (minimum-swaps-digit-sum nums)
  (let* ([n (length nums)]
         [indices (range n)]
         [sums (map (λ (x) (apply + (map (λ (c) (- (char->integer c) (char->integer #\0))) (string->list (number->string x))))) nums)]
         [sorted-indices (sort indices (λ (i j) (< (list-ref sums i) (list-ref sums j))))]
         [visited (make-vector n #f)]
         [swaps (let loop ([swaps 0])
                  (if (every? identity visited)
                      swaps
                      (let* ([i (findf (λ (i) (not (vector-ref visited i))) indices)]
                             [cycle-len (let loop2 ([curr i] [len 0])
                                          (if (vector-ref visited curr)
                                              len
                                              (begin
                                                (vector-set! visited curr #t)
                                                (loop2 (list-ref sorted-indices curr) (+ len 1)))))]
                             [new-swaps (+ swaps (- cycle-len 1))])
                        (loop new-swaps))))])
    swaps))