(define (count-points rings)
  (let loop ([i 0]
             [rods (make-hash)])
    (if (>= i (string-length rings))
        (count (lambda (rod) (and (hash-has-key? rod 'R)
                                  (hash-has-key? rod 'G)
                                  (hash-has-key? rod 'B)))
               (hash-values rods))
        (let* ([color (string-ref rings i)]
               [rod (string->number (string (string-ref rings (+ i 1))))]
               [rod-hash (hash-ref rods rod (make-hash))])
          (hash-set! rod-hash color #t)
          (hash-set! rods rod rod-hash)
          (loop (+ i 2) rods)))))