#lang racket

(define (diagonal-sort mat)
  (define rows (length mat))
  (define cols (length (car mat)))

  ;; Convert input list-of-lists to vector-of-vectors for mutable access
  (define mat-vec (build-vector rows (lambda (i) (list->vector (list-ref mat i)))))

  ;; Map to store elements for each diagonal
  ;; Key: i - j (diagonal identifier)
  ;; Value: List of elements in that diagonal
  (define diagonals (make-hash))

  ;; Populate the diagonals map
  (for ([i (in-range rows)])
    (for ([j (in-range cols)])
      (define k (- i j))
      (hash-set! diagonals k (append (hash-ref diagonals k '()) (list (vector-ref (vector-ref mat-vec i) j))))))

  ;; Sort each diagonal's elements
  (for ([k (hash-keys diagonals)])
    (hash-set! diagonals k (sort (hash-ref diagonals k) <)))

  ;; Create a new mutable matrix (vector of vectors) to store the sorted result
  (define result-mat-vec (build-vector rows (lambda (x) (make-vector cols 0))))

  ;; A map to keep track of the current index for each sorted diagonal list
  (define diagonal-indices (make-hash))

  ;; Fill the result matrix with sorted diagonal elements
  (for ([i (in-range rows)])
    (for ([j (in-range cols)])
      (define k (- i j))
      (define sorted-diag (hash-ref diagonals k))
      (define current-idx (hash-ref diagonal-indices k 0))

      ;; Place the element
      (vector-set! (vector-ref result-mat-vec i) j (list-ref sorted-diag current-idx))

      ;; Increment the index for this diagonal
      (hash-set! diagonal-indices k (+ current-idx 1))))

  ;; Convert the result back to list-of-lists as expected by LeetCode
  (build-list rows (lambda (i) (vector->list (vector-ref result-mat-vec i)))))