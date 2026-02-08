(define (min-deletion-size strs)
  (define num-rows (length strs))
  (if (zero? num-rows)
      0
      (begin
        (define num-cols (string-length (first strs)))

        (define (column-is-unsorted? col-idx)
          (for/or ([row-idx (in-range (- num-rows 1))])
            (define char1 (string-ref (list-ref strs row-idx) col-idx))
            (define char2 (string-ref (list-ref strs (+ row-idx 1)) col-idx))
            (char> char1 char2)))

        (for/sum ([col-idx (in-range num-cols)])
          (if (column-is-unsorted? col-idx)
              1
              0)))))