(define (modify-columns mat)
  (if (empty? mat)
      '()
      (let* ((num-rows (length mat))
             (num-cols (length (car mat)))
             ;; Transpose the matrix to work with columns
             ;; (apply map list mat) converts rows to columns
             (columns (apply map list mat))
             ;; Modify each column based on its index
             (modified-columns
              (for/list ([col columns]
                         [j (in-naturals)])
                ;; Example modification:
                ;; If column index j is even, increment all elements by 1.
                ;; If column index j is odd, decrement all elements by 1.
                (if (even? j)
                    (map add1 col)
                    (map sub1 col)))))
        ;; Transpose back to get the result in row-major order
        (apply map list modified-columns))))