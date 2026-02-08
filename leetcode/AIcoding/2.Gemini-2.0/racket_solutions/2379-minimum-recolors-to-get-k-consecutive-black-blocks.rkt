(define (minimum-recolors blocks k)
  (let* ((n (string-length blocks))
         (whites (for/list ((i (in-range 0 k)))
                   (if (char=? (string-ref blocks i) #\W) 1 0)))
         (initial-count (apply + whites)))
    (let loop ((i 1)
               (min-recolors initial-count))
      (if (>= i (- n k 0))
          min-recolors
          (let* ((new-count (- min-recolors
                               (if (char=? (string-ref blocks (- i 1)) #\W) 1 0)
                               0))
                 (final-count (+ new-count
                               (if (char=? (string-ref blocks (+ i k -1)) #\W) 1 0)
                               0)))
            (loop (+ i 1) (min min-recolors final-count)))))))