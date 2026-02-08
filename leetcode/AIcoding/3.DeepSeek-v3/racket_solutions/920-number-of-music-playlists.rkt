(define (num-music-playlists n goal k)
  (define mod 1000000007)
  (define dp (make-vector (+ goal 1) (make-vector (+ n 1) 0)))
  (vector-set! (vector-ref dp 0) 0 1)
  (for ([i (in-range 1 (+ goal 1))])
    (for ([j (in-range 1 (+ n 1))])
      (vector-set! (vector-ref dp i) j 
                   (modulo 
                    (+ (* (vector-ref (vector-ref dp (- i 1)) (- j 1)) 
                       (if (> j k) 
                           (* (vector-ref (vector-ref dp (- i 1)) j) (- j k)) 
                           0)) 
                    mod))))
  (vector-ref (vector-ref dp goal) n))