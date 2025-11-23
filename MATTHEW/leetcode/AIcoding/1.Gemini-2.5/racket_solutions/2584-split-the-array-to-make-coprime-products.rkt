#lang racket

(require math/prime)
(require data/hash-set)

(define (split-array-to-make-coprime-products nums)
  (define n (vector-length nums))

  ;; Step 1: Precompute prime factors for each number in nums
  ;; Store as a vector of hash-sets for efficient set operations.
  (define nums-prime-factors
    (build-vector n
                  (lambda (j)
                    (list->hash-set (prime-factors (vector-ref nums j))))))

  ;; Step 2: Precompute prefix-factors-union
  ;; prefix-factors-unions[i] stores the union of prime factors
  ;; for all numbers from nums[0] up to nums[i].
  (define prefix-factors-unions (make-vector n (hash-set)))
  (vector-set! prefix-factors-unions 0 (vector-ref nums-prime-factors 0))
  (for ([j (in-range 1 n)])
    (vector-set! prefix-factors-unions j
                 (hash-set-union (vector-ref prefix-factors-unions (- j 1))
                                 (vector-ref nums-prime-factors j))))

  ;; Step 3: Precompute suffix-factors-union
  ;; suffix-factors-unions[j] stores the union of prime factors
  ;; for all numbers from nums[j] up to nums[n-1].
  (define suffix-factors-unions (make-vector n (hash-set)))
  (vector-set! suffix-factors-unions (- n 1) (vector-ref nums-prime-factors (- n 1)))
  (for ([j (in-range (- n 2) -1 -1)]) ; Iterate j from n-2 down to 0
    (vector-set! suffix-factors-unions j
                 (hash-set-union (vector-ref nums-prime-factors j)
                                 (vector-ref suffix-factors-unions (+ j 1)))))

  ;; Step 4: Iterate through possible split points i
  ;; A split at index i means the left part is nums[0...i]
  ;; and the right part is nums[i+1...n-1].
  ;; The index i can range from 0 to n-2 (inclusive), as both parts must be non-empty.
  (for/first ([i (in-range (- n 1))] ; Iterate i from 0 to n-2
              #:when (let ([left-set (vector-ref prefix-factors-unions i)]
                           [right-set (vector-ref suffix-factors-unions (+ i 1))])
                       ;; Check if the intersection of prime factors is empty,
                       ;; meaning the products are coprime.
                       (hash-set-empty? (hash-set-intersection left-set right-set))))
    i ; If a coprime split is found, return the current index i
    #:else -1)) ; If no such index i is found after checking all possibilities, return -1