(define/contract (maximum-energy energy k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let loop ([i (- (length energy) 1)] [max-energy -inf.0] [dp (make-hash)])
    (if (< i 0)
        max-energy
        (let* ([current (list-ref energy i)]
               [next (if (>= (+ i k) (length energy)) 0 (hash-ref dp (+ i k) 0))]
               [total (+ current next)])
          (hash-set! dp i total)
          (loop (- i 1) (max max-energy total) dp)))))