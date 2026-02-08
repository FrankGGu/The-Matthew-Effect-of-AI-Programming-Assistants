#lang racket

(define (maximum-subarray-with-equal-products nums)
  (define N (length nums))

  (define (solve-no-zeros arr)
    (define current-N (length arr))
    (if (< current-N 2)
        0
        (let ([all-subarrays '()])
          ;; Generate all subarrays and their products
          (for ([i (in-range current-N)])
            (let loop-j ([j i] [current-prod 1])
              (when (< j current-N)
                (define new-prod (* current-prod (list-ref arr j)))
                (set! all-subarrays (cons (list new-prod i j) all-subarrays))
                (loop-j (+ j 1) new-prod))))

          ;; Group subarrays by their product
          (define product-to-intervals (make-hash))
          (for ([item all-subarrays])
            (define prod (list-ref item 0))
            (define s (list-ref item 1))
            (define e (list-ref item 2))
            (hash-table-set! product-to-intervals prod
                             (cons (list s e) (hash-table-ref product-to-intervals prod '()))))

          (let ([max-overall-len 0])
            ;; For each distinct product
            (for ([prod (hash-keys product-to-intervals)])
              (define intervals (hash-table-ref product-to-intervals prod))
              (when (>= (length intervals) 2)
                ;; Sort intervals by their start index
                (define sorted-intervals (sort intervals (lambda (a b) (< (list-ref a 0) (list-ref b 0)))))

                (let ([min-s-for-left-part +inf.0] ; Smallest start index encountered so far
                      [max-e-for-left-part -inf.0] ; Largest end index encountered so far
                      [current-max-len-for-prod 0])

                  ;; Iterate through sorted intervals, treating each as a potential right subarray
                  (for ([interval sorted-intervals])
                    (define s-curr (list-ref interval 0))
                    (define e-curr (list-ref interval 1))

                    ;; If there's a valid left part encountered so far (min-s-for-left-part is not +inf.0)
                    ;; AND the current interval (s-curr, e-curr) does not overlap with any interval
                    ;; that contributed to min-s-for-left-part (i.e., max-e-for-left-part < s-curr),
                    ;; then we have found a pair of non-overlapping subarrays with equal products.
                    (when (and (not (= min-s-for-left-part +inf.0))
                               (< max-e-for-left-part s-curr))
                      (set! current-max-len-for-prod
                            (max current-max-len-for-prod (+ (- e-curr min-s-for-left-part) 1))))

                    ;; Update min-s-for-left-part and max-e-for-left-part for future iterations.
                    ;; These track the minimum start and maximum end of the union of intervals processed so far.
                    (set! min-s-for-left-part (min min-s-for-left-part s-curr))
                    (set! max-e-for-left-part (max max-e-for-left-part e-curr)))

                  (set! max-overall-len (max max-overall-len current-max-len-for-prod))))
            max-overall-len))))

  ;; Handle zeros
  (define zero-indices '())
  (for ([i (in-range N)])
    (when (= (list-ref nums i) 0)
      (set! zero-indices (cons i zero-indices))))

  (set! zero-indices (sort zero-indices <)) ; Sort indices for consistent sublist splitting

  (cond
    ;; If there are two or more zeros, we can always pick two single-element subarrays [0] and [0].
    ;; Their products are equal (0), and they are non-overlapping. The maximum length is N.
    [(>= (length zero-indices) 2) N]
    ;; If there is exactly one zero, we cannot form two subarrays with product 0.
    ;; Any two subarrays with equal non-zero products must lie entirely to the left or entirely to the right of the single zero.
    [(= (length zero-indices) 1)
     (let ([zero-idx (car zero-indices)])
       (define left-part (if (> zero-idx 0) (sublist nums 0 zero-idx) '()))
       (define right-part (if (< zero-idx (- N 1)) (sublist nums (+ zero-idx 1) N) '()))
       (max (solve-no-zeros left-part) (solve-no-zeros right-part)))]
    ;; If there are no zeros, solve the problem for the entire array.
    [else (solve-no-zeros nums)]))