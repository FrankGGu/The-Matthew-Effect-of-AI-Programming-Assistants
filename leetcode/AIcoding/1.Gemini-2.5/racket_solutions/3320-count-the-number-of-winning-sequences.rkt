(define (count-winning-sequences nums k)
  (define MOD 1000000007)

  ;; Coordinate compression
  (define unique-sorted-nums
    (sort (remove-duplicates nums) <))
  (define value-to-rank
    (make-hash))
  (for ([i (in-range (length unique-sorted-nums))]
        [val unique-sorted-nums])
    (hash-set! value-to-rank val i))
  (define M (length unique-sorted-nums))

  ;; Fenwick tree (BIT) implementation
  ;; make-fenwick-tree returns a list of two procedures: (update-fn query-fn)
  ;; All indices are 0-based for update/query procedures.
  (define (make-fenwick-tree size)
    (define tree (make-vector (+ size 1) 0)) ; Internal tree is 1-indexed

    (define (update idx val) ; idx is 0-indexed
      (let loop ((i (+ idx 1)))
        (when (<= i size)
          (vector-set! tree i (modulo (+ (vector-ref tree i) val) MOD))
          (loop (+ i (bitwise-and i (- i)))))))

    (define (query idx) ; idx is 0-indexed, returns prefix sum up to idx
      (let loop ((i (+ idx 1)) (sum 0))
        (if (zero? i)
            sum
            (loop (bitwise-and i (- i)) (modulo (+ sum (vector-ref tree i)) MOD)))))
    (list update query))

  ;; Initialize K Fenwick trees
  ;; bit-trees[j] stores counts for subsequences of length j
  (define bit-trees (make-vector (+ k 1) #f))
  (for ([j (in-range 1 (+ k 1))])
    (vector-set! bit-trees j (make-fenwick-tree M)))

  ;; Dynamic programming iteration
  (for ([val nums])
    (define rank (hash-ref value-to-rank val))
    ;; Iterate from k down to 1 to ensure counts for length 'len' are based on
    ;; 'len-1' subsequences that do not include the current 'val' yet.
    (for ([len (in-range k 0 -1)])
      (define current-bit-update (car (vector-ref bit-trees len)))
      (define prev-bit-query (cadr (vector-ref bit-trees (- len 1))))

      (define count 0)
      (cond
        [(= len 1)
         ;; A single element forms an increasing subsequence of length 1
         (set! count 1)]
        [else
         ;; Query for sum of counts of length (len-1) subsequences ending with a value less than 'val'
         (when (> rank 0) ; Only query if there are smaller ranks to consider
           (set! count (prev-bit-query (- rank 1))))])

      ;; If we found any valid subsequences, update the current length's BIT
      (when (> count 0)
        (current-bit-update rank count))))

  ;; The final answer is the sum of all counts for length k subsequences
  ;; which is the total sum in the Fenwick tree for length k.
  (define final-query (cadr (vector-ref bit-trees k)))
  (final-query (- M 1))) ; Query sum up to the maximum rank (M-1)