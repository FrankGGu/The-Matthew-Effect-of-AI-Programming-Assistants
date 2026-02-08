#lang racket

(define (min-operations nums k)
  (define n (vector-length nums))
  (define max-xor-val 1024) ; Max possible XOR sum (2^10 since nums[i] <= 1000)
  (define infinity (expt 2 30)) ; A sufficiently large integer for infinity

  ; dp[x] stores the minimum operations for the first 'j' columns
  ; such that their XOR sum is 'x'.
  ; We use two arrays to alternate between current and next DP states.
  (define dp (make-vector max-xor-val infinity))
  (vector-set! dp 0 0) ; Base case: 0 columns processed, XOR sum 0, cost 0

  (for ([j (in-range k)]) ; Iterate through each of the k columns (from 0 to k-1)
    (define next-dp (make-vector max-xor-val infinity))

    ; Calculate frequency map and count of elements for current column j
    (define freq-map (make-hash))
    (define col-elements-count 0)
    (for ([i (in-range j n k)]) ; Iterate elements in column j: nums[j], nums[j+k], nums[j+2k], ...
      (define val (vector-ref nums i))
      (hash-update! freq-map val add1 0)
      (set! col-elements-count (+ col-elements-count 1)))

    ; Find the minimum value in the current dp array
    (define min-val-in-current-dp infinity)
    (for ([x (in-range max-xor-val)])
      (set! min-val-in-current-dp (min min-val-in-current-dp (vector-ref dp x))))

    ; Case 1: The value chosen for the current column 'j' (let's call it 'v')
    ; is NOT one of the distinct values originally present in column 'j'.
    ; In this case, the cost for column 'j' is 'col-elements-count' (all elements changed).
    ; For any 'target-xor', the minimum cost is 'min-val-in-current-dp + col-elements-count'.
    (for ([target-xor (in-range max-xor-val)])
      (vector-set! next-dp target-xor (+ min-val-in-current-dp col-elements-count)))

    ; Case 2: The value chosen for the current column 'j' ('v')
    ; IS one of the distinct values originally present in column 'j'.
    ; Iterate through each distinct value 'v' found in the current column's elements.
    (hash-for-each
     freq-map
     (lambda (v count)
       (define cost-for-v (- col-elements-count count)) ; Cost to make all elements in col j equal to v
       (for ([prev-xor (in-range max-xor-val)])
         (when (< (vector-ref dp prev-xor) infinity) ; Only consider reachable previous states
           (define target-xor (bitwise-xor prev-xor v))
           (vector-set! next-dp
                        target-xor
                        (min (vector-ref next-dp target-xor)
                             (+ (vector-ref dp prev-xor) cost-for-v)))))))

    (set! dp next-dp)) ; Update dp to the next state

  ; The final answer is the minimum cost to make the XOR sum of all k columns equal to 0.
  (vector-ref dp 0))