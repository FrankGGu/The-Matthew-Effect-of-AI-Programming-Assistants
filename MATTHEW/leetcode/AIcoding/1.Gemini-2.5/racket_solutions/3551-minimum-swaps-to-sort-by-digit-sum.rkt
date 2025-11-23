#lang racket

(define (digit-sum n)
  (if (= n 0)
      0
      (+ (remainder n 10) (digit-sum (quotient n 10)))))

(define (min-swaps-to-sort-by-digit-sum nums)
  (define n (length nums))

  (when (<= n 1)
    (set! nums '()) ; Clear nums to avoid unused variable warning if not used
    0)

  (define items
    (for/list ([n-val (in-indexed nums)]
               [idx (in-naturals)])
      (list (digit-sum n-val) n-val idx)))

  (define sorted-items
    (sort items
          (lambda (a b)
            (let ([sum-a (first a)]
                  [sum-b (first b)])
              (if (= sum-a sum-b)
                  (< (second a) (second b)) ; Tie-break by original value
                  (< sum-a sum-b))))))

  ; `p` is a permutation vector. `p[i]` stores the original index of the element
  ; that should be at position `i` in the sorted array.
  ; For example, if sorted-items is `((s=3 v=12 idx=0) (s=3 v=30 idx=2) (s=4 v=4 idx=1))`,
  ; then `p` will be `(vector 0 2 1)`.
  ; We want to find the minimum swaps to transform the array of current indices `(0 1 ... n-1)`
  ; into the permutation `p`.
  ; This is equivalent to finding the minimum swaps to sort `p` into `(0 1 ... n-1)`.
  (define p (make-vector n))
  (for ([item sorted-items] [i (in-naturals)])
    (vector-set! p i (third item))) ; (third item) is the original index

  (define visited (make-vector n #f))
  (define swaps 0)

  (for ([i (in-range n)])
    (unless (vector-ref visited i)
      (let ([cycle-len 0])
        (let loop ([j i])
          (unless (vector-ref visited j)
            (vector-set! visited j #t)
            (set! cycle-len (+ cycle-len 1))
            (loop (vector-ref p j)))) ; Follow the cycle: element `j` goes to `p[j]`

        (when (> cycle-len 0) ; If a cycle was found (even length 1)
          (set! swaps (+ swaps (- cycle-len 1)))))))
  swaps)