(define (calculate-score s k)
  (let* ([n (string-length s)]
         [score (make-vector n 0)]
         [l 0]
         [r (- n 1)])
    (for ([i (in-range (length k))])
      (let* ([instruction (list-ref k i)]
             [index (string->number instruction)])
        (cond
          [(<= index l)
           (vector-set! score index 1)
           (set! l (+ l 1))]
          [(>= index r)
           (vector-set! score index 1)
           (set! r (- r 1))]
          [else
           (let ([left-dist (- index l)]
                 [right-dist (- r index)])
             (if (<= left-dist right-dist)
                 (begin
                   (vector-set! score index 1)
                   (set! l (+ l 1)))
                 (begin
                   (vector-set! score index 1)
                   (set! r (- r 1)))))])))
    (vector->list score)))