#lang racket

(define (mark-elements-on-array-by-performing-queries nums queries)
  (define n (length nums))
  (define nums-vec (list->vector nums))
  (define visited (make-vector n #f)) ; #f for unmarked, #t for marked
  (define current-sum (for/sum ([x (in-vector nums-vec)]) x))
  (define results '())

  ; Create a vector of (value . original-index) pairs
  (define indexed-nums (build-vector n (lambda (i) (cons (vector-ref nums-vec i) i))))

  ; Sort this vector by value
  (define sorted-indexed-nums (vector-sort indexed-nums (lambda (a b) (< (car a) (car b)))))

  (define sorted-ptr 0) ; Pointer to the next smallest element in sorted-indexed-nums to consider

  (for ([query queries])
    (define idx (car query))
    (define k (cadr query))

    ; Step 1: Mark nums[idx]
    (define original-val-at-idx (vector-ref nums-vec idx))
    (when (not (vector-ref visited idx))
      (set! current-sum (- current-sum original-val-at-idx))
      (vector-set! visited idx #t))

    ; Step 2: Mark k smallest unmarked elements
    (let loop-k-smallest ([remaining-k k])
      (when (and (> remaining-k 0) (< sorted-ptr n))
        (define pair (vector-ref sorted-indexed-nums sorted-ptr))
        (define val (car pair))
        (define original-idx (cdr pair))

        (set! sorted-ptr (+ sorted-ptr 1)) ; Always advance sorted-ptr to consider the next element in the sorted list

        (if (not (vector-ref visited original-idx))
            ; This element is currently unmarked, so mark it
            (begin
              (set! current-sum (- current-sum val))
              (vector-set! visited original-idx #t)
              (loop-k-smallest (- remaining-k 1))) ; Recurse to find the next (remaining-k - 1) smallest unmarked
            ; This element was already marked (either by a previous query's Step 1 or Step 2)
            ; Skip it and continue looking for an unmarked element among the smallest
            (loop-k-smallest remaining-k)))) ; Recurse with the same remaining-k, as no element was marked in this iteration

    ; Step 3: Store current-sum
    (set! results (cons current-sum results)))

  (reverse results))