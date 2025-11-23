#lang racket

(define (minimum-total-cost nums1 nums2 cost)
  (define n (vector-length nums1))
  (define total-cost 0)
  (define freq (make-hash)) ; Stores count of values that are equal at an index

  ; First pass: calculate base cost for equal pairs and count their frequencies
  (for ([i (in-range n)])
    (let ([v1 (vector-ref nums1 i)]
          [v2 (vector-ref nums2 i)]
          [c (vector-ref cost i)])
      (if (= v1 v2)
          (begin
            (set! total-cost (+ total-cost c))
            (hash-update! freq v1 add1 0))
          ; For unequal pairs, we don't swap them initially (cost 0)
          ; These will be considered later if a dominant value needs fixing
          )))

  ; Find the value that appears most frequently among the equal pairs
  (define max-freq-val #f)
  (define max-freq-count 0)

  (hash-for-each
   freq
   (lambda (val count)
     (when (> count max-freq-count)
       (set! max-freq-count count)
       (set! max-freq-val val))))

  ; If there are no equal pairs, the initial total-cost is 0, and we are done.
  (when (eq? max-freq-val #f)
    (set! max-freq-val -1)) ; Use a dummy value if no dominant value, to avoid #f in later comparisons

  ; If max-freq-count is 0, it means no nums1[i] == nums2[i] initially.
  ; In this case, total-cost is 0, and we return it.
  (when (= max-freq-count 0)
    (set! max-freq-val -1)) ; Ensure max-freq-val is not #f for the next block

  (define remaining-to-fix max-freq-count)
  (define potential-swaps-costs '())

  ; Collect costs of swaps for unequal pairs that involve the max-freq-val
  ; These swaps can help "balance" the dominant value
  (for ([i (in-range n)])
    (let ([v1 (vector-ref nums1 i)]
          [v2 (vector-ref nums2 i)]
          [c (vector-ref cost i)])
      (unless (= v1 v2) ; Only consider unequal pairs
        (when (or (= v1 max-freq-val)
                  (= v2 max-freq-val))
          (set! potential-swaps-costs (cons c potential-swaps-costs))))))

  ; Sort these potential swap costs in ascending order to pick the cheapest ones
  (set! potential-swaps-costs (sort potential-swaps-costs <))

  ; Greedily apply swaps to fix the dominant value
  (for ([c (in-list potential-swaps-costs)])
    (when (> remaining-to-fix 0)
      (set! total-cost (+ total-cost c))
      (set! remaining-to-fix (- remaining-to-fix 1))))

  ; If we still have occurrences of the dominant value that need fixing, it's impossible
  (if (> remaining-to-fix 0)
      -1
      total-cost))