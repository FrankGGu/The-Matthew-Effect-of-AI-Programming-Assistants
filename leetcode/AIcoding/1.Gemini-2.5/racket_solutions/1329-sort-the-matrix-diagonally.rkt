#lang racket

(define (diagonal-sort mat)
  (define m (length mat))
  (define n (length (car mat))) ; Problem constraints: 1 <= m, n <= 100, so (car mat) is safe.

  ;; Convert list of lists to vector of vectors for mutability
  (define vmat (list->vector (map list->vector mat)))

  ;; Iterate through all possible diagonal 'k' values
  ;; A diagonal is defined by i - j = k.
  ;; The smallest k is when i=0, j=n-1, so k = 0 - (n-1) = -(n-1).
  ;; The largest k is when i=m-1, j=0, so k = (m-1) - 0 = m-1.
  ;; (in-range start end) generates numbers from start up to (but not including) end.
  ;; So, for k from -(n-1) to (m-1) inclusive, the range is (in-range (-(sub1 n)) m).
  (for ([k (in-range (-(sub1 n)) m)])
    (define current-diagonal '())
    ;; Determine the starting row and column for the current diagonal
    (define start-row (max 0 k))
    (define start-col (max 0 (- k)))

    ;; Extract elements for the current diagonal
    (let loop ((r start-row) (c start-col))
      (when (and (< r m) (< c n))
        (set! current-diagonal (cons (vector-ref (vector-ref vmat r) c) current-diagonal))
        (loop (+ r 1) (+ c 1))))

    ;; Sort the extracted elements in ascending order
    (set! current-diagonal (sort current-diagonal <))

    ;; Put sorted elements back into the matrix along the same diagonal
    (let loop ((r start-row) (c start-col) (sorted-elements current-diagonal))
      (when (and (< r m) (< c n))
        (vector-set! (vector-ref vmat r) c (car sorted-elements))
        (loop (+ r 1) (+ c 1) (cdr sorted-elements)))))

  ;; Convert vector of vectors back to list of lists for the final result
  (vector->list (map vector->list vmat)))