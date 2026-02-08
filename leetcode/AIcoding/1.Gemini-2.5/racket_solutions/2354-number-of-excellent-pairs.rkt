#lang racket

(define (number-of-excellent-pairs nums k)
  ;; Step 1: Get unique numbers from nums and sort them
  (define unique-nums (sort (list->set nums) <))

  ;; Helper to safely get the count from a trie node
  (define (get-count node)
    (if node
        (hash-ref node 'count 0)
        0))

  ;; Trie node structure: (hash "0" child0 "1" child1 'count total-numbers-in-subtree)
  ;; Using strings "0" and "1" as keys for children
  (define root (hash 'count 0))
  (define MAX_BITS 30) ; Numbers up to 10^9, 2^29 < 10^9 < 2^30

  ;; Function to insert a number into the Trie
  (define (insert-trie num)
    (define current root)
    (set! (hash-ref current 'count) (+ (hash-ref current 'count) 1))
    (for ([i (range (- MAX_BITS 1) -1 -1)])
      (define bit (bitwise-and (arithmetic-shift num (- i)) 1))
      (define bit-str (number->string bit))
      (define child (hash-ref current bit-str #f))
      (unless child
        (set! child (hash 'count 0))
        (hash-set! current bit-str child))
      (set! current child)
      (set! (hash-ref current 'count) (+ (hash-ref current 'count) 1))))

  ;; Function to query the Trie for numbers y such that (x | y) >= k
  (define (count-ge-k x k)
    (define total-pairs-for-x 0)
    (define (traverse node bit-idx)
      (when node
        (if (< bit-idx 0)
            ;; If bit-idx is less than 0, it means we've successfully matched
            ;; or surpassed k in higher bits. All numbers in this subtree are valid.
            (set! total-pairs-for-x (+ total-pairs-for-x (hash-ref node 'count)))
            (let* ([x-bit (bitwise-and (arithmetic-shift x (- bit-idx)) 1)]
                   [k-bit (bitwise-and (arithmetic-shift k (- bit-idx)) 1)]
                   [child0 (hash-ref node "0" #f)]
                   [child1 (hash-ref node "1" #f)])

              (if (= k-bit 0)
                  ;; If k_bit is 0, we can satisfy (x | y) >= k if (x | y)_bit is 1.
                  (if (= x-bit 0)
                      (begin
                        ;; If y_bit = 1, then (x|y)_bit = 1 > k_bit = 0.
                        ;; All numbers in child1's subtree are good.
                        (set! total-pairs-for-x (+ total-pairs-for-x (get-count child1)))
                        ;; If y_bit = 0, then (x|y)_bit = 0 = k_bit = 0.
                        ;; Continue matching in child0's subtree.
                        (traverse child0 (- bit-idx 1)))
                      ;; If x_bit = 1, then (x|y)_bit will always be 1 regardless of y_bit.
                      ;; This means (x|y)_bit = 1 > k_bit = 0.
                      ;; All numbers in both child0 and child1's subtrees are good.
                      (begin
                        (set! total-pairs-for-x (+ total-pairs-for-x (get-count child0)))
                        (set! total-pairs-for-x (+ total-pairs-for-x (get-count child1)))))
                  ;; If k_bit is 1, we must have (x | y)_bit = 1 to potentially satisfy (x | y) >= k.
                  (if (= x-bit 0)
                      ;; If x_bit = 0, we must pick y_bit = 1 to make (x|y)_bit = 1 = k_bit.
                      ;; Continue matching in child1's subtree.
                      (traverse child1 (- bit-idx 1))
                      ;; If x_bit = 1, then (x|y)_bit will always be 1 regardless of y_bit.
                      ;; This means (x|y)_bit = 1 = k_bit = 1.
                      ;; Continue matching in both child0 and child1's subtrees.
                      (begin
                        (traverse child0 (- bit-idx 1))
                        (traverse child1 (- bit-idx 1))))))))
    (traverse root (- MAX_BITS 1))
    total-pairs-for-x)

  (define total-excellent-pairs 0)
  (define U_lt_k '())
  (define count-ge-k-in-U 0)

  ;; Separate unique numbers into those >= k and those < k
  (for ([num unique-nums])
    (if (>= num k)
        (set! count-ge-k-in-U (+ count-ge-k-in-U 1))
        (set! U_lt_k (cons num U_lt_k))))

  ;; Reverse U_lt_k to maintain original sorted order if needed, or just sort.
  ;; Since `cons` adds to the front, `(list->set nums)` already handles uniqueness.
  ;; `U_lt_k` is built in reverse order, but its elements are iterated over individually.
  ;; The order of insertion into Trie or querying doesn't affect correctness for this problem.
  ;; (set! U_lt_k (sort U_lt_k <)) ; Not strictly necessary if order doesn't matter for iteration.

  ;; Step 2: Count pairs (x, y) where at least one of x, y is >= k
  ;; These pairs automatically satisfy x|y >= k because x|y >= max(x,y).
  ;; Using inclusion-exclusion: |A union B| = |A| + |B| - |A intersect B|
  ;; A = { (x,y) | x >= k }, B = { (x,y) | y >= k }
  ;; |A| = count-ge-k-in-U * |unique-nums|
  ;; |B| = |unique-nums| * count-ge-k-in-U
  ;; |A intersect B| = count-ge-k-in-U * count-ge-k-in-U
  (define U-size (length unique-nums))
  (set! total-excellent-pairs
        (+ total-excellent-pairs
           (- (* 2 count-ge-k-in-U U-size)
              (* count-ge-k-in-U count-ge-k-in-U))))

  ;; Step 3 & 4: For pairs (x, y) where x, y < k and (x | y) >= k
  ;; Build Trie for numbers in U_lt_k
  (for ([num U_lt_k])
    (insert-trie num))

  ;; Query for each x in U_lt_k to find y in U_lt_k such that (x | y) >= k
  (for ([x U_lt_k])
    (set! total-excellent-pairs (+ total-excellent-pairs (count-ge-k x k))))

  total-excellent-pairs)