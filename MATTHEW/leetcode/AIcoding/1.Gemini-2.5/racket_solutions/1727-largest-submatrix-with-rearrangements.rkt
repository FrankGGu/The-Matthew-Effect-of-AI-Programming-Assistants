(define (largest-submatrix matrix)
  (let* ([rows (length matrix)]
         [cols (if (null? matrix) 0 (length (car matrix)))])

    (if (or (zero? rows) (zero? cols))
        0 ; Return 0 for empty matrix or matrix with empty rows/cols
        (let* (;; Calculate heights of consecutive 1s for each column
               ;; `prev-row-heights` stores heights from the row above.
               ;; `acc-heights` accumulates the rows of calculated heights.
               [calculated-heights
                (let loop ([r 0] [prev-row-heights (build-list cols (lambda (c) 0))] [acc-heights '()])
                  (if (= r rows)
                      (reverse acc-heights)
                      (let* ([matrix-row (list-ref matrix r)]
                             [current-row-heights
                              (map (lambda (matrix-val prev-height)
                                     (if (= matrix-val 1)
                                         (+ 1 prev-height)
                                         0))
                                   matrix-row
                                   prev-row-heights)])
                        (loop (+ r 1) current-row-heights (cons current-row-heights acc-heights)))))]
               ;; Calculate the maximum area by iterating through each row of heights
               [max-area
                (for/fold ([acc-max-area 0])
                          ([row-heights (in-list calculated-heights)])
                  (let* ([sorted-row (sort row-heights >)] ; Sort heights in descending order
                         [current-row-max-area
                          (for/fold ([acc 0])
                                    ([h (in-list sorted-row)]
                                     [idx (in-naturals)]) ; idx starts from 0
                            ;; Area for a bar of height h at index idx is h * (idx + 1)
                            (max acc (* h (+ idx 1))))])
                    (max acc-max-area current-row-max-area)))])
          max-area))))