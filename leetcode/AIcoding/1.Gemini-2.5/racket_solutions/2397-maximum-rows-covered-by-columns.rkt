#lang racket

(define (maximum-rows-covered-by-columns mat cols)
  (define m (length mat))
  (define n (length (car mat))) ; Assumes mat is non-empty

  ;; Helper function to count set bits in an integer
  (define (count-set-bits num)
    (let loop ((k num) (count 0))
      (if (zero? k)
          count
          (loop (arithmetic-shift k -1) (+ count (bitwise-and k 1))))))

  (let ((max-covered 0))
    ;; Iterate through all possible column masks from 0 to 2^n - 1
    (for ((mask (in-range (expt 2 n))))
      ;; Check if the current mask selects exactly 'cols' columns
      (when (= (count-set-bits mask) cols)
        ;; Calculate the number of rows covered by this specific column selection
        (let ((current-covered-rows
                (for/sum ((row-idx (in-range m)))
                  ;; A row is covered if any of its '1's fall into a selected column
                  (if (for/or ((col-idx (in-range n)))
                        (and (= 1 (list-ref (list-ref mat row-idx) col-idx))
                             (not (zero? (bitwise-and mask (arithmetic-shift 1 col-idx))))))
                      1 ; This row is covered
                      0))))
          ;; Update the maximum number of covered rows found so far
          (set! max-covered (max max-covered current-covered-rows)))))
    max-covered))