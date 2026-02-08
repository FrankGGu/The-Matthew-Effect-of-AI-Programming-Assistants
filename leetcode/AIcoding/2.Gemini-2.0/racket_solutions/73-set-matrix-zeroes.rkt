(define (set-zeroes matrix)
  (let* ((m (length matrix))
         (n (length (car matrix)))
         (first-row-zero? #f)
         (first-col-zero? #f))

    (for/or ((j (in-range n)))
      (if (= (list-ref (car matrix) j) 0)
          (set! first-row-zero? #t)))

    (for/or ((i (in-range m)))
      (if (= (list-ref (list-ref matrix i) 0) 0)
          (set! first-col-zero? #t)))

    (for ((i (in-range 1 m)))
      (for ((j (in-range 1 n)))
        (if (= (list-ref (list-ref matrix i) j) 0)
            (begin
              (set! (list-ref (car matrix) j) 0)
              (set! (list-ref (list-ref matrix i) 0) 0)))))

    (for ((i (in-range 1 m)))
      (for ((j (in-range 1 n)))
        (if (or (= (list-ref (car matrix) j) 0)
                (= (list-ref (list-ref matrix i) 0) 0))
            (set! (list-ref (list-ref matrix i) j) 0))))

    (if first-row-zero?
        (for ((j (in-range n)))
          (set! (list-ref (car matrix) j) 0)))

    (if first-col-zero?
        (for ((i (in-range m)))
          (set! (list-ref (list-ref matrix i) 0) 0)))

    matrix))