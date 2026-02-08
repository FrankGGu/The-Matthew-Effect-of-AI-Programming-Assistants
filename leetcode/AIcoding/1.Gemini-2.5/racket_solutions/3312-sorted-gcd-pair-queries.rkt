(define (solve nums k)
  (define n (vector-length nums))
  (define max-val (if (zero? n) 0 (vector-ref nums (- n 1))))

  ; If there are fewer than 2 elements, no pairs can be formed.
  ; The problem usually guarantees n >= 2 for valid k.
  ; Returning 0 or an error might be appropriate based on problem specifics.
  ; For competitive programming, assume valid input where k can be satisfied.
  (when (< n 2)
    (error "Not enough elements to form pairs"))

  ; Helper function to count pairs (i, j) with i < j such that gcd(nums[i], nums[j]) > g_min
  ; This function recomputes auxiliary arrays for each call, leading to O(M log^2 M) complexity.
  ; For multiple queries, precomputing these arrays once would be more efficient.
  (define (count-gt g_min)
    (if (<= g_min 0)
        (quotient (* n (- n 1)) 2) ; All pairs have GCD > 0
        (let* ([freq (make-vector (+ max-val 1) 0)]
               [multiples-count (make-vector (+ max-val 1) 0)]
               [f (make-vector (+ max-val 1) 0)]
               [count-gcd (make-vector (+ max-val 1) 0)])

          ; 1. Populate freq array: count occurrences of each number in nums
          (for ([x nums])
            (vector-set! freq x (+ (vector-ref freq x) 1)))

          ; 2. Populate multiples-count: count numbers in nums that are multiples of g
          ; multiples-count[g] = sum_{m=g, 2g, ...} freq[m]
          (for ([g (in-range 1 (+ max-val 1))])
            (for ([m (in-range g (+ max-val 1) g)])
              (vector-set! multiples-count g (+ (vector-ref multiples-count g) (vector-ref freq m)))))

          ; 3. Populate f: number of pairs (x, y) such that g divides gcd(x, y)
          ; This is (count of multiples of g in nums) choose 2
          (for ([g (in-range 1 (+ max-val 1))])
            (let ([c (vector-ref multiples-count g)])
              (vector-set! f g (quotient (* c (- c 1)) 2))))

          ; 4. Populate count-gcd: number of pairs (x, y) such that gcd(x, y) = g
          ; Using inclusion-exclusion: count-gcd[g] = f[g] - sum_{k=2,3,...} count-gcd[k*g]
          (for ([g (in-range max-val 0 -1)]) ; Iterate from max-val down to 1
            (vector-set! count-gcd g (vector-ref f g))
            (for ([m (in-range (* 2 g) (+ max-val 1) g)]) ; Iterate multiples of g (2g, 3g, ...)
              (vector-set! count-gcd g (- (vector-ref count-gcd g) (vector-ref count-gcd m)))))

          ; 5. Sum count-gcd for g > g_min
          (let ([total-gt 0])
            (for ([g (in-range (+ g_min 1) (+ max-val 1))])
              (set! total-gt (+ total-gt (vector-ref count-gcd g))))
            total-gt))))

  ; Binary search for the K-th smallest GCD value
  (let* ([total-pairs (quotient (* n (- n 1)) 2)])
    (let loop ([low 1] [high max-val] [ans max-val])
      (if (> low high)
          ans
          (let* ([mid (quotient (+ low high) 2)]
                 ; num-pairs-gt-mid counts pairs with gcd > mid
                 [num-pairs-gt-mid (count-gt mid)]
                 ; num-pairs-le-mid counts pairs with gcd <= mid
                 [num-pairs-le-mid (- total-pairs num-pairs-gt-mid)])
            (if (>= num-pairs-le-mid k)
                ; If there are at least k pairs with GCD <= mid,
                ; then mid is a possible answer. Try to find a smaller one.
                (loop low (- mid 1) mid)
                ; If there are fewer than k pairs with GCD <= mid,
                ; then mid is too small. Need a larger GCD.
                (loop (+ mid 1) high ans)))))))