#lang racket

(define (minimum-absolute-difference-in-sliding-submatrix grid k)
  (define m (vector-length grid))
  (define n (vector-length (vector-ref grid 0)))

  (define result (make-vector (- m k -1)))
  (for ([i (in-range (- m k -1))])
    (vector-set! result i (make-vector (- n k -1) 0)))

  ;; Assuming grid values are non-negative and within a small range, e.g., 0 to 100.
  ;; If values can be larger, a different data structure (e.g., an ordered-set
  ;; with counts) would be required for frequency counting and min-diff calculation.
  (define V_MAX 100) 

  (define (get-min-abs-diff freq)
    (let loop ([val 0]
               [min-diff +inf.0]
               [prev-val -1])
      (cond
        [(= val (+ V_MAX 1)) min-diff] ; Base case: finished iterating
        [(= min-diff 0) min-diff] ; Optimization: if min-diff is already 0, no need to continue
        [(> (vector-ref freq val) 0)
         (if (> (vector-ref freq val) 1)
             (loop (+ val 1) 0 prev-val) ; Found duplicate, min-diff is 0
             (if (not (= prev-val -1))
                 (loop (+ val 1) (min min-diff (- val prev-val)) val)
                 (loop (+ val 1) min-diff val)))]
        [else (loop (+ val 1) min-diff prev-val)])))

  ;; col-freqs[c] is a frequency vector for the elements in the current k-height slice
  ;; of column c (i.e., grid[r...r+k-1][c]).
  (define col-freqs (make-vector n (lambda () (make-vector (+ V_MAX 1) 0))))

  (for ([r (in-range (- m k -1))]) ; Iterate through top-left row index of the submatrix
    ;; Step 1: Initialize/Update col-freqs for the current k-height block grid[r...r+k-1][0...n-1]
    ;; This loop updates the vertical window for each new 'r'.
    (for ([c (in-range n)])
      (define current-col-freq (vector-ref col-freqs c))
      ;; Reset frequency for this column's vector
      (for ([val (in-range (+ V_MAX 1))]) (vector-set! current-col-freq val 0))
      ;; Populate frequency for this column's k-height slice
      (for ([i (in-range r (+ r k))])
        (define val (vector-ref (vector-ref grid i) c))
        (vector-set! current-col-freq val (+ (vector-ref current-col-freq val) 1))))

    ;; Step 2: Slide horizontally for this row 'r'
    (define current-window-freq (make-vector (+ V_MAX 1) 0))

    ;; Initialize for the first k x k submatrix (grid[r...r+k-1][0...k-1])
    (for ([c-idx (in-range k)])
      (define col-f (vector-ref col-freqs c-idx))
      (for ([val (in-range (+ V_MAX 1))])
        (vector-set! current-window-freq val
                     (+ (vector-ref current-window-freq val) (vector-ref col-f val)))))

    (vector-set! (vector-ref result r) 0 (get-min-abs-diff current-window-freq))

    ;; Slide window horizontally for the rest of the columns
    (for ([c (in-range 1 (- n k -1))])
      ;; Remove frequency counts of column (c-1) from current-window-freq
      (define prev-col-f (vector-ref col-freqs (- c 1)))
      (for ([val (in-range (+ V_MAX 1))])
        (vector-set! current-window-freq val
                     (- (vector-ref current-window-freq val) (vector-ref prev-col-f val))))

      ;; Add frequency counts of column (c+k-1) to current-window-freq
      (define next-col-f (vector-ref col-freqs (+ c k -1)))
      (for ([val (in-range (+ V_MAX 1))])
        (vector-set! current-window-freq val
                     (+ (vector-ref current-window-freq val) (vector-ref next-col-f val))))

      (vector-set! (vector-ref result r) c (get-min-abs-diff current-window-freq))))

  result)