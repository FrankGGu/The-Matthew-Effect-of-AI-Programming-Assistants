(define/contract (equal-substring s t maxCost)
  (-> string? string? exact-integer? exact-integer?)
  (let ([n (string-length s)]
        [cost (make-vector (string-length s) 0)])
    (for ([i (in-range n)])
      (vector-set! cost i (abs (- (char->integer (string-ref s i)) 
                                  (char->integer (string-ref t i))))))
    (let loop ([left 0] [right 0] [current 0] [max-len 0])
      (cond
        [(>= right n) max-len]
        [else
         (let ([new-current (+ current (vector-ref cost right))])
           (if (<= new-current maxCost)
               (loop left (+ right 1) new-current (max max-len (+ (- right left) 1)))
               (loop (+ left 1) right (- current (vector-ref cost left)) max-len))])))))