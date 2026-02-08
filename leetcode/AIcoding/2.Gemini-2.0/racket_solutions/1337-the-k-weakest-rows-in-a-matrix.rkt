(define (k-weakest-rows mat k)
  (define (count-soldiers row)
    (foldl + 0 row))

  (define rows-with-indices
    (map (lambda (row index) (list (count-soldiers row) index))
         mat
         (range (length mat))))

  (define sorted-rows
    (sort rows-with-indices
          (lambda (a b)
            (if (= (first a) (first b))
                (< (second a) (second b))
                (< (first a) (first b))))))

  (map second (take sorted-rows k)))