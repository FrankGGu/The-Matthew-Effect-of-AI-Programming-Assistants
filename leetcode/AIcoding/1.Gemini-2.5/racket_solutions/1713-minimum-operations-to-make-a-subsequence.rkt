#lang racket

(define (min-operations target arr)
  (define n (length target))

  ;; 1. Create a hash map to store the index of each element in 'target'.
  ;;    This allows O(1) average time lookup for elements from 'arr'.
  (define target-pos (make-hash))
  (for ([val (in-list target)]
        [idx (in-naturals)])
    (hash-set! target-pos val idx))

  ;; 2. Filter 'arr' to create a list of indices from 'target' that appear in 'arr'.
  ;;    The order of these indices must correspond to their appearance in 'arr'.
  (define relevant-indices
    (for/list ([val (in-list arr)]
               #:when (hash-has-key? target-pos val))
      (hash-ref target-pos val)))

  ;; 3. Find the Longest Increasing Subsequence (LIS) of 'relevant-indices'.
  ;;    This is done using the patience sorting algorithm, which maintains a 'tails' array.
  ;;    'tails[i]' stores the smallest ending element of an increasing subsequence of length (i+1).
  ;;    'tails-vec' is a mutable vector to store these tails, pre-allocated to max possible size 'n'.
  ;;    'tails-len' tracks the current effective length of the LIS.
  (define tails-vec (make-vector n #f)) ; Vector to store the smallest tail of LIS of various lengths
  (define tails-len 0) ; Current length of the LIS

  ;; Helper function for binary search: finds the smallest element in tails-vec[0...tails-len-1]
  ;; that is greater than or equal to 'val'. Returns its index.
  (define (binary-search-smallest-ge val)
    (let loop ([low 0] [high tails-len] [ans tails-len])
      (if (>= low high)
          ans
          (let ([mid (+ low (quotient (- high low) 2))])
            (if (>= (vector-ref tails-vec mid) val)
                (loop low mid mid) ; Current mid could be the answer, try left half
                (loop (+ mid 1) high ans)))))) ; Current mid is too small, try right half

  ;; Iterate through 'relevant-indices' to build the LIS.
  (for ([x (in-list relevant-indices)])
    (let ([idx (binary-search-smallest-ge x)])
      (cond
        [(= idx tails-len) ; 'x' is greater than all elements in 'tails-vec', extend LIS
         (vector-set! tails-vec tails-len x)
         (set! tails-len (+ tails-len 1))]
        [else ; 'x' can replace 'tails-vec[idx]' to form a smaller end for an LIS of length (idx+1)
         (vector-set! tails-vec idx x)])))

  ;; The length of the LIS is 'tails-len'.
  (define lis-length tails-len)

  ;; 4. The minimum operations required is the total length of 'target'
  ;;    minus the length of the longest common subsequence (which is the LIS length).
  (- n lis-length))