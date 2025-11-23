#lang racket

(define (find-right-interval intervals)
  (define n (length intervals))

  ; Convert the input list of intervals to a vector for O(1) access
  (define intervals-vec (list->vector intervals))

  ; Create a list of (start-value . original-index) pairs
  (define indexed-starts
    (for/list ([interval intervals]
               [idx (in-range n)])
      (cons (car interval) idx)))

  ; Sort these pairs by their start-value
  (define sorted-indexed-starts-list
    (sort indexed-starts (lambda (a b) (< (car a) (car b)))))

  ; Convert the sorted list of (start . original-index) to a vector for O(1) binary search access
  (define sorted-indexed-starts-vec (list->vector sorted-indexed-starts-list))

  ; Binary search function to find the first element with start >= target
  ; Returns the (start . original-index) pair or #f if no such element is found
  (define (binary-search-lower-bound target)
    (let loop ((low 0)
               (high (sub1 (vector-length sorted-indexed-starts-vec)))
               (result-pair #f)) ; Stores the (start . original-index) of the best candidate found so far
      (if (> low high)
          result-pair
          (let* ((mid (quotient (+ low high) 2))
                 (current-pair (vector-ref sorted-indexed-starts-vec mid))
                 (current-start (car current-pair)))
            (if (>= current-start target)
                ; current-pair's start is >= target, it's a potential candidate.
                ; Try to find an even smaller start in the left half.
                (loop low (sub1 mid) current-pair)
                ; current-pair's start is too small, look in the right half.
                (loop (add1 mid) high result-pair))))))

  ; Initialize the results vector with -1 for all intervals
  (define results (make-vector n -1))

  ; Iterate through the original intervals (using the vector for O(1) access)
  ; and find the right interval for each
  (for ([i (in-range n)])
    (define current-interval (vector-ref intervals-vec i))
    (define end-val (cadr current-interval)) ; Get the end value of the current interval

    (define found-pair (binary-search-lower-bound end-val))

    (when found-pair
      ; If a suitable right interval is found, store its original index in the results
      (vector-set! results i (cdr found-pair))))

  ; Convert the result vector to a list as required by LeetCode's typical output format
  (vector->list results))