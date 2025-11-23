(define (max-fruits-harvested fruits startPos k)
  (define n (vector-length fruits))
  (if (= n 0) 0
      (begin
        (define max-harvest 0)
        (define current-harvest 0)
        (define left-idx 0)

        (define (get-pos idx) (vector-ref (vector-ref fruits idx) 0))
        (define (get-amount idx) (vector-ref (vector-ref fruits idx) 1))

        ;; Helper to calculate the minimum steps required to collect fruits
        ;; within the range [p_L, p_R] starting from startPos.
        (define (calculate-cost p_L p_R startPos)
          (cond
            ;; Case 1: startPos is to the left of the entire range [p_L, p_R].
            ;; Must move right from startPos to p_R.
            [(<= startPos p_L) (- p_R startPos)]
            ;; Case 2: startPos is to the right of the entire range [p_L, p_R].
            ;; Must move left from startPos to p_L.
            [(>= startPos p_R) (- startPos p_L)]
            ;; Case 3: startPos is within the range [p_L, p_R].
            ;; Must visit both ends. Two options:
            ;; 1. Go left to p_L, then turn around and go right to p_R. Steps = (startPos - p_L) + (p_R - p_L)
            ;; 2. Go right to p_R, then turn around and go left to p_L. Steps = (p_R - startPos) + (p_R - p_L)
            ;; The minimum of these is (p_R - p_L) + min(startPos - p_L, p_R - startPos).
            [else (+ (- p_R p_L) (min (- startPos p_L) (- p_R startPos)))]))

        (for ([right-idx (in-range n)])
          (set! current-harvest (+ current-harvest (get-amount right-idx)))

          (let ([p_R (get-pos right-idx)])
            ;; Shrink the window from the left if the current cost exceeds k.
            (do ()
                [(or (> left-idx right-idx) ; Window is empty or invalid
                     (<= (calculate-cost (get-pos left-idx) p_R startPos) k))] ; Current window is valid

              (let ([p_L (get-pos left-idx)])
                (when (> (calculate-cost p_L p_R startPos) k)
                  (set! current-harvest (- current-harvest (get-amount left-idx)))
                  (set! left-idx (+ left-idx 1))))))

          (set! max-harvest (max max-harvest current-harvest)))

        max-harvest)))