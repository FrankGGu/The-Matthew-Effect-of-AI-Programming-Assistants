(define (min-deletion-size A)
  (let* ((rows (length A))
         (cols (if (null? A) 0 (string-length (first A))))
         (del-count 0))
    (for ([j (in-range cols)])
      (let loop ([i 1])
        (cond
          [(= i rows) #f]
          [(char<=? (string-ref (list-ref A (- i 1)) j) (string-ref (list-ref A i) j))
           (loop (+ i 1))]
          [else
           (set! del-count (+ del-count 1))
           #t])))
    del-count))