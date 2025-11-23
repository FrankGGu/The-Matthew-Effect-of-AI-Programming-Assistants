#lang racket/base

(define (make-bit size)
  (make-vector (+ size 1) 0)) ; 1-indexed internal array

(define (bit-update! bit idx val)
  (let loop ((i (+ idx 1))) ; Convert 0-indexed to 1-indexed for BIT
    (when (<= i (vector-length bit))
      (vector-set! bit i (+ (vector-ref bit i) val))
      (loop (+ i (bitwise-and i (- i)))))))

(define (bit-query bit idx)
  (let loop ((i idx) ; This 'i' is the 1-indexed upper bound for query
             (sum 0))
    (if (zero? i)
        sum
        (loop (bitwise-and i (- i))
              (+ sum (vector-ref bit i))))))

(define (find-kth-unmoved-digit-idx bit n k-val)
  (let loop ((low 0) (high (- n 1)) (ans -1))
    (if (<= low high)
        (let* ((mid (quotient (+ low high) 2))
               ; Count of unmoved digits from 0 to mid (inclusive)
               ; (mid + 1) is the total number of elements up to mid
               ; (bit-query bit (+ mid 1)) is the count of moved elements up to mid
               (unmoved-count-at-mid (- (+ mid 1) (bit-query bit (+ mid 1)))))
          ; We are looking for the (k-val + 1)-th unmoved element (1-indexed)
          (if (<= (+ k-val 1) unmoved-count-at-mid)
              (loop low (- mid 1) mid) ; Try left half, mid is a candidate
              (loop (+ mid 1) high ans))) ; Else, try right half
        ans)))

(define (min-integer num k)
  (let* ((n (string-length num))
         (pos (make-vector 10 (list))) ; vector of lists for each digit '0'-'9'
         (bit (make-bit n)) ; Fenwick tree for N elements (0 to N-1)
         (result-chars (make-vector n #\space))) ; Use a vector of chars as a mutable string builder

    ; Populate pos: Prepend indices to lists, then reverse to get original order
    (for ((idx (in-range n)))
      (let* ((char (string-ref num idx))
             (digit (- (char->integer char) (char->integer #\0))))
        (vector-set! pos digit (cons idx (vector-ref pos digit)))))
    (for ((digit (in-range 10)))
      (vector-set! pos digit (reverse (vector-ref pos digit))))

    (let loop ((res-idx 0)
               (current-k k))
      (when (< res-idx n)
        (if (zero? current-k)
            ;; If k is 0, append remaining digits in their original relative order
            (let ((unmoved-rank 0))
              (for ((i res-idx (in-range n)))
                (let* ((original-idx-to-fill (find-kth-unmoved-digit-idx bit n unmoved-rank)))
                  (vector-set! result-chars i (string-ref num original-idx-to-fill))
                  (bit-update! bit original-idx-to-fill 1) ; Mark as moved
                  (set! unmoved-rank (+ unmoved-rank 1)))))
            ;; Otherwise, find the smallest digit
            (let search-digit ((digit 0)
                               (found-and-placed #f)) ; Flag to break inner loop
              (if (and (< digit 10) (not found-and-placed))
                  (let ((digit-positions (vector-ref pos digit)))
                    (if (empty? digit-positions)
                        (search-digit (+ digit 1) found-and-placed) ; Try next digit
                        (let* ((original-idx (car digit-positions))
                               ;; Swaps needed: (current_original_pos - target_original_pos) - (elements_already_moved_in_between)
                               ;; current_original_pos is `original-idx`
                               ;; target_original_pos is `res-idx` (conceptually)
                               ;; elements_already_moved_in_between is `(bit-query bit original-idx) - (bit-query bit res-idx)`
                               (swaps-needed (- original-idx res-idx (- (bit-query bit original-idx) (bit-query bit res-idx)))))
                          (if (<= swaps-needed current-k)
                              ;; Found the smallest digit that can be moved
                              (begin
                                (vector-set! result-chars res-idx (integer->char (+ (char->integer #\0) digit)))
                                (vector-set! pos digit (cdr digit-positions)) ; Remove from queue
                                (bit-update! bit original-idx 1) ; Mark as moved
                                (loop (+ res-idx 1) (- current-k swaps-needed))) ; Continue to next position
                              ;; Cannot move this digit, try next digit
                              (search-digit (+ digit 1) found-and-placed))))
                  ;; This branch should not be taken if current-k > 0 and res-idx < n,
                  ;; as there must always be a digit to place.
                  #f ; Placeholder for the `if` expression, actual control flow is via `loop`
                  ))))
    (vector->string result-chars)))