(define (cherry-pickup-ii grid)
  (define R (vector-length grid))
  (define C (vector-length (vector-ref grid 0)))
  (define memo (make-hash))
  (define invalid-path-val -1000000000) ; A very small number to represent an invalid path

  (define (dp row col1 col2)
    (let ((key (list row col1 col2)))
      (cond
        ((hash-has-key? memo key)
         (hash-ref memo key))

        ;; Base case: last row
        ((= row (- R 1))
         (let ((current-cherries
                 (+ (vector-ref (vector-ref grid row) col1)
                    (if (= col1 col2) 0 (vector-ref (vector-ref grid row) col2)))))
           (hash-set! memo key current-cherries)
           current-cherries))

        ;; Recursive step
        (else
         (let* ((current-cherries
                  (+ (vector-ref (vector-ref grid row) col1)
                     (if (= col1 col2) 0 (vector-ref (vector-ref grid row) col2))))
                (max-future-cherries invalid-path-val)
                (possible-dc (list -1 0 1)))
           (for-each (lambda (dc1)
                       (for-each (lambda (dc2)
                                   (let ((next-col1 (+ col1 dc1))
                                         (next-col2 (+ col2 dc2)))
                                     ;; Check if next columns are valid before making recursive call
                                     (when (and (>= next-col1 0) (< next-col1 C)
                                                (>= next-col2 0) (< next-col2 C))
                                       (set! max-future-cherries
                                             (max max-future-cherries
                                                  (dp (add1 row) next-col1 next-col2)))))))
                     possible-dc)
           (let ((total-cherries (+ current-cherries max-future-cherries)))
             (hash-set! memo key total-cherries)
             total-cherries))))))

  ;; Initial call: robots start at (0, 0) and (0, C-1)
  (dp 0 0 (- C 1)))