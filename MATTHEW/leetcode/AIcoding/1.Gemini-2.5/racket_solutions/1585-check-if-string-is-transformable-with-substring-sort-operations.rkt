#lang racket

(define (make-fenwick-tree size)
  ;; size is the maximum index (1-based)
  ;; tree-array stores the BIT values
  (define tree-array (make-vector (+ size 1) 0))
  (define N size)

  ;; Update operation: adds val to element at index idx (1-based)
  (define (update idx val)
    (let loop ((i idx))
      (when (<= i N)
        (vector-set! tree-array i (+ (vector-ref tree-array i) val))
        (loop (+ i (bitwise-and i (- i)))))))

  ;; Query operation: sums elements from 1 to idx (1-based)
  (define (query idx)
    (let loop ((i idx) (sum 0))
      (if (> i 0)
          (loop (- i (bitwise-and i (- i))) (+ sum (vector-ref tree-array i)))
          sum)))

  ;; Query range [low, high] (1-based)
  (define (query-range low high)
    (if (> low high)
        0
        (- (query high) (query (- low 1)))))

  (list update query query-range))

(define (char->digit c)
  (- (char->integer c) (char->integer #\0)))

(define (is-transformable s t)
  (define N (string-length s))

  ;; 1. Check if s and t are anagrams
  (define s-counts (make-vector 10 0))
  (define t-counts (make-vector 10 0))

  (for ([i (in-range N)])
    (vector-set! s-counts (char->digit (string-ref s i))
                 (+ (vector-ref s-counts (char->digit (string-ref s i))) 1))
    (vector-set! t-counts (char->digit (string-ref t i))
                 (+ (vector-ref t-counts (char->digit (string-ref t i))) 1)))

  (for ([d (in-range 10)])
    (unless (= (vector-ref s-counts d) (vector-ref t-counts d))
      (returns #f))) ; Use a named let/return to exit early

  ;; 2. Create queues of original indices for each digit in s
  (define s-idx-queues (make-vector 10 (make-queue)))
  (for ([i (in-range N)])
    (enqueue! (vector-ref s-idx-queues (char->digit (string-ref s i))) i))

  ;; 3. Initialize 10 Fenwick trees
  (define bits (make-vector 10 #f)) ; #f will be replaced by (list update query query-range)
  (for ([d (in-range 10)])
    (vector-set! bits d (make-fenwick-tree N)))

  ;; Populate BITs with initial positions of digits in s
  (for ([i (in-range N)])
    (let* ((digit (char->digit (string-ref s i)))
           (update-fn (car (vector-ref bits digit))))
      (update-fn (+ i 1) 1))) ; BIT indices are 1-based

  ;; 4. Iterate through t and check transformability
  (call-with-current-continuation
   (lambda (returns)
     (for ([i (in-range N)])
       (let* ((target-digit (char->digit (string-ref t i)))
              (q (vector-ref s-idx-queues target-digit)))
         (when (queue-empty? q)
           ;; This case should ideally not be hit if anagram check passed,
           ;; but included for robustness.
           (returns #f))

         (let* ((original-s-idx (dequeue! q)) ; 0-based index
                (original-s-idx-1based (+ original-s-idx 1)))

           ;; Remove this digit from its BIT
           (let ((update-fn (car (vector-ref bits target-digit))))
             (update-fn original-s-idx-1based -1))

           ;; Check for blocking digits (smaller digits to the left that are still active)
           (for ([d-blocker (in-range target-digit)])
             (let ((query-range-fn (caddr (vector-ref bits d-blocker))))
               ;; Query for active d-blockers in the range [1, original-s-idx-1based - 1]
               ;; which corresponds to 0-based indices [0, original-s-idx - 1]
               (when (> (query-range-fn 1 (- original-s-idx-1based 1)) 0)
                 (returns #f))))))) ; Return false if a blocker is found

   #t)) ; If all checks pass, return true

(define/contract (check-if-string-is-transformable-with-substring-sort-operations s t)
  (-> string? string? boolean?)
  (is-transformable s t))