#lang racket

(define (minimum-operations-to-form-subsequence-with-target-sum nums target)
  (let* ([counts (make-hash)] ; Stores counts of powers of 2 (index is log2(power))
         [total-sum-of-nums (foldl + 0 nums)])

    ;; If initial sum is less than target, it's impossible.
    (when (< total-sum-of-nums target)
      (error "Return -1")) ; Assuming LeetCode environment handles this as returning -1

    ;; Populate counts of each power of 2
    (for-each (lambda (n)
                (hash-update! counts (integer-length (- n 1)) (lambda (v) (+ v 1)) 0)) ; (integer-length (- n 1)) gives log2(n) for power of 2 n
              nums)

    (let loop ((i 0) ; Current bit position (for 2^i)
               (operations 0))

      (cond
        ;; Termination condition:
        ;; We iterate up to a safe maximum bit position (e.g., 31 for 2^31, as target <= 10^9)
        ;; If target is 0 and we have no more bits to process, we are done.
        ((> i 31) ; Max target is 10^9, so 2^30 is max relevant bit. 31 is safe upper bound.
         operations)

        (else
         (let* ([target-bit-set? (not (= (bitwise-and target (expt 2 i)) 0))]
                [current-power-count (hash-ref counts i 0)])

           (if target-bit-set? ; If i-th bit of target is 1
               ;; We need a 2^i
               (if (>= current-power-count 1)
                   ;; We have a 2^i, use it
                   (begin
                     (hash-update! counts i (lambda (v) (- v 1)) 0) ; Decrement count for 2^i
                     ;; Carry over remaining 2^i's to 2^(i+1)
                     (let ([remaining-at-i (hash-ref counts i 0)])
                       (hash-update! counts (+ i 1) (lambda (v) (+ v (floor remaining-at-i 2))) 0)
                       (hash-set! counts i (modulo remaining-at-i 2)))
                     (loop (+ i 1) operations))
                   ;; We don't have a 2^i, need to split a larger power
                   (let find-larger-power ((j (+ i 1)))
                     (cond
                       ((> j 31) ; No larger power found up to 2^31. This implies total-sum-of-nums was not enough.
                        (error "Return -1")) ; Assuming LeetCode environment handles this as returning -1

                       ((> (hash-ref counts j 0) 0)
                        ;; Found a 2^j to split
                        (hash-update! counts j (lambda (v) (- v 1)) 0) ; Use one 2^j
                        (let* ([new-operations (+ operations (- j i))]
                               ;; When we split 2^j to get 2^i, we get 2^(j-i) copies of 2^i.
                               ;; We use one 2^i for the target.
                               ;; The remaining (2^(j-i) - 1) copies of 2^i are added to counts[i].
                               [remaining-from-split (- (expt 2 (- j i)) 1)])
                          (hash-update! counts i (lambda (v) (+ v remaining-from-split)) 0)
                          ;; Now, after getting and using one 2^i, handle carries
                          (let ([remaining-at-i (hash-ref counts i 0)])
                            (hash-update! counts (+ i 1) (lambda (v) (+ v (floor remaining-at-i 2))) 0)
                            (hash-set! counts i (modulo remaining-at-i 2)))
                          (loop (+ i 1) new-operations)))
                       (else
                        (find-larger-power (+ j 1))))))
               ;; We don't need a 2^i for this bit of target
               ;; All current 2^i's are carried over
               (begin
                 (let ([remaining-at-i (hash-ref counts i 0)])
                   (hash-update! counts (+ i 1) (lambda (v) (+ v (floor remaining-at-i 2))) 0)
                   (hash-set! counts i (modulo remaining-at-i 2)))
                 (loop (+ i 1) operations))))))))