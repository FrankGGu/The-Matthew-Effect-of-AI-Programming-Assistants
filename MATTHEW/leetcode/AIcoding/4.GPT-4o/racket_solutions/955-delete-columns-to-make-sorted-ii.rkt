(define (min-deletion-size A)
  (define (check-sorted col)
    (let loop ((i 1))
      (if (>= i (length A))
          #t
          (if (string<=? (string-ref (list-ref A i) col) (string-ref (list-ref A (- i 1)) col))
              (loop (+ i 1))
              #f))))

  (define (remove-column col)
    (for ((i (in-range (length A))))
      (set! A (list-ref A i (remove col (range (string-length (list-ref A i))))))))

  (define (delete-columns)
    (define deleted-cols '())
    (for ((col (in-range (string-length (list-ref A 0)))))
      (if (not (member col deleted-cols))
          (if (check-sorted col)
              (set! deleted-cols (cons col deleted-cols))
              (remove-column col))))
    (length deleted-cols))

  (delete-columns))