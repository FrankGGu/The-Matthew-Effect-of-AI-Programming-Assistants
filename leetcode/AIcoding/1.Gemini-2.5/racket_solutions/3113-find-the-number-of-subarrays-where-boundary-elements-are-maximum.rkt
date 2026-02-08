#lang racket

(struct idx-count (idx count) #:transparent)

(define (find-the-number-of-subarrays-where-boundary-elements-are-maximum nums)
  (define n (vector-length nums))
  (define ans 0)
  (define st '()) ; Stack of idx-count structs

  (for ([i (in-range n)])
    (define current-val (vector-ref nums i))
    (define current-count 1) ; Initialize count for the single-element subarray (i, i)

    ;; Pop elements from the stack whose values are strictly less than current-val.
    ;; These elements cannot be the maximum for any subarray ending at or after 'i'
    ;; if 'current-val' is a boundary.
    (let loop-pop ()
      (when (and (not (empty? st))
                 (< (vector-ref nums (idx-count-idx (car st))) current-val))
        (set! st (cdr st))
        (loop-pop)))

    ;; If the top of the stack has a value equal to current-val,
    ;; it means the element at (idx-count-idx (car st)) is a valid left boundary
    ;; for subarrays ending at 'i'. The count associated with it (idx-count-count (car st))
    ;; represents the number of such valid left boundaries that end at (idx-count-idx (car st)).
    ;; Since current-val is equal and all elements between (idx-count-idx (car st)) and 'i'
    ;; are less than or equal to current-val (due to stack maintenance),
    ;; all those previous valid subarrays can be extended to 'i'.
    (when (and (not (empty? st))
               (= (vector-ref nums (idx-count-idx (car st))) current-val))
      (set! current-count (+ current-count (idx-count-count (car st)))))

    ;; Add the current-count to the total answer.
    ;; current-count now includes (i, i) and all (j, i) where j is a valid left boundary.
    (set! ans (+ ans current-count))

    ;; Push the current index and its calculated count onto the stack.
    (set! st (cons (idx-count i current-count) st)))

  ans)