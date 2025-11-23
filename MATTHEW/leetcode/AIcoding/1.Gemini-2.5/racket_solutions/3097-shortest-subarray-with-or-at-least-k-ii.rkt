(define (shortest-subarray-with-or-at-least-k-ii nums k)
  (let* ([nums-vec (list->vector nums)]
         [n (vector-length nums-vec)]
         [bit-counts (make-vector 30 0)]) ; To store counts of each bit set in the window

    (define l 0)
    (define current-or-sum 0)
    (define min-len (+ n 1)) ; Initialize with a value larger than any possible length

    (for ([r (in-range n)])
      (let ([num_r (vector-ref nums-vec r)])

        ; Add num_r to window and update current-or-sum
        (set! current-or-sum (bitwise-ior current-or-sum num_r))
        (for ([i (in-range 30)])
          (when (not (= 0 (bitwise-and num_r (arithmetic-shift 1 i))))
            (vector-set! bit-counts i (+ (vector-ref bit-counts i) 1))))

        ; Shrink window from left while condition met
        (while (and (<= l r) (>= current-or-sum k))
          (set! min-len (min min-len (+ (- r l) 1)))

          (let ([num_l (vector-ref nums-vec l)])
            ; Remove num_l from window and update current-or-sum
            (for ([i (in-range 30)])
              (when (not (= 0 (bitwise-and num_l (arithmetic-shift 1 i))))
                (vector-set! bit-counts i (- (vector-ref bit-counts i) 1))
                ; If count of this bit becomes 0, it's no longer in the OR sum
                (when (= (vector-ref bit-counts i) 0)
                  (set! current-or-sum (bitwise-and current-or-sum (bitwise-not (arithmetic-shift 1 i)))))))

            (set! l (+ l 1))))))

    (if (= min-len (+ n 1)) -1 min-len)))