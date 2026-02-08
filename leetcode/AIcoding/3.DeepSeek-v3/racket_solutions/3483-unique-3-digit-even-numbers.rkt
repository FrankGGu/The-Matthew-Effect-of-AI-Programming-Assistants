(define (count-even-numbers digits)
  (let loop ((i 0) (count 0))
    (if (>= i (length digits))
        count
        (let ((x (list-ref digits i)))
          (if (zero? (modulo x 2))
              (loop (+ i 1) (+ count (count-valid-numbers digits x)))
              (loop (+ i 1) count))))))

(define (count-valid-numbers digits last-digit)
  (let ((used (make-hash)))
    (hash-set! used last-digit #t)
    (let loop ((i 0) (count 0))
      (if (>= i (length digits))
          count
          (let ((x (list-ref digits i)))
            (if (hash-ref used x #f)
                (loop (+ i 1) count)
                (let ((new-used (hash-copy used)))
                  (hash-set! new-used x #t)
                  (loop (+ i 1) (+ count (count-hundreds digits new-used x last-digit))))))))))

(define (count-hundreds digits used middle-digit last-digit)
  (let loop ((i 0) (count 0))
    (if (>= i (length digits))
        count
        (let ((x (list-ref digits i)))
          (if (or (hash-ref used x #f) (zero? x))
              (loop (+ i 1) count)
              (loop (+ i 1) (+ count 1)))))))

(define (count-even-numbers-main digits)
  (count-even-numbers digits))