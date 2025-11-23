(define (can-arrays-pairs-divisible-by-k? arr k)
  (let ([remainders (make-hash)])
    (for ([num arr])
      (let ([r (modulo num k)])
        (hash-update! remainders 
                      (if (negative? r) (+ r k) r 
                      (lambda (v) (+ v 1)) 0)))
    (if (not (zero? (modulo (hash-ref remainders 0 0) 2)))
        #f
        (let loop ([i 1])
          (if (>= i k)
              #t
              (let ([count (hash-ref remainders i 0)])
                (if (not (= count (hash-ref remainders (- k i) 0)))
                    #f
                    (loop (+ i 1))))))))