(define (delivering-boxes-from-storage-to-ports boxes ports-count max-boxes max-weight)
  (define n (length boxes))

  (when (= n 0)
    (error "No boxes to deliver"))

  ;; Convert boxes to vectors for O(1) access
  (define P (make-vector n)) ; Ports
  (define W (make-vector n)) ; Weights
  (for ([i (in-range n)])
    (vector-set! P i (car (list-ref boxes i)))
    (vector-set! W i (cadr (list-ref boxes i))))

  ;; Precompute prefix sums of weights
  ;; prefix-weights[k] = sum of weights of boxes[0...k-1]
  ;; prefix-weights[0] = 0
  (define prefix-weights (make-vector (+ n 1) 0))
  (for ([i (in-range n)])
    (vector-set! prefix-weights (+ i 1) (+ (vector-ref prefix-weights i) (vector-ref W i))))

  ;; Precompute port differences
  ;; port-diffs[k] = sum_{m=1}^{k-1} (if P_m != P_{m-1} then 1 else 0)
  ;; This means port-diffs[k] is the number of port changes up to P[k-1].
  ;; port-diffs[0] = 0
  ;; port-diffs[1] = 0 (no P[-1] to compare P[0] with)
  ;; port-diffs[k] = port-diffs[k-1] + (if P[k-1] != P[k-2] then 1 else 0) for k >= 2
  ;; This vector needs to be indexed up to n. So size n+1.
  (define port-diffs (make-vector (+ n 1) 0))
  (for ([i (in-range 2 (+ n 1))])
    (vector-set! port-diffs i
                 (+ (vector-ref port-diffs (- i 1))
                    (if (not (= (vector-ref P (- i 1)) (vector-ref P (- i 2)))) 1 0))))

  ;; DP array
  (define dp (make-vector (+ n 1) +inf.0))
  (vector-set! dp 0 0)

  ;; Deque implementation using two lists for efficiency
  ;; (list front-list back-list) where front-list is in normal order, back-list is reversed
  (define (make-deque) (list '() '()))
  (define (deque-empty? dq) (and (null? (car dq)) (null? (cadr dq))))
  (define (deque-front dq)
    (let ([front (car dq)] [back (cadr dq)])
      (if (null? front)
          (car (reverse back))
          (car front))))
  (define (deque-back dq)
    (let ([front (car dq)] [back (cadr dq)])
      (if (null? back)
          (car (reverse front))
          (car back))))
  (define (deque-push-back dq x) (list (car dq) (cons x (cadr dq))))
  (define (deque-pop-front dq)
    (let ([front (car dq)] [back (cadr dq)])
      (if (null? front)
          (let ([new-front (reverse back)])
            (list (cdr new-front) '()))
          (list (cdr front) back))))
  (define (deque-pop-back dq)
    (let ([front (car dq)] [back (cadr dq)])
      (if (null? back)
          (let ([new-back (reverse front)])
            (list '() (cdr new-back)))
          (list front (cdr back)))))

  (define current-dq (make-deque))
  (set! current-dq (deque-push-back current-dq 0)) ; Add initial state dp[0]

  (for ([i (in-range 1 (+ n 1))])
    ;; Remove elements from front of dq that are too far left (too many boxes)
    ;; j < i - max_boxes => j <= i - max_boxes - 1
    (let loop-max-boxes ([dq-val current-dq])
      (if (and (not (deque-empty? dq-val))
               (< (deque-front dq-val) (- i max-boxes)))
          (loop-max-boxes (deque-pop-front dq-val))
          (set! current-dq dq-val)))

    ;; Remove elements from front of dq that exceed max_weight
    ;; prefix-weights[i] - prefix-weights[j] > max_weight
    ;; prefix-weights[j] < prefix-weights[i] - max_weight
    (let loop-max-weight ([dq-val current-dq])
      (if (and (not (deque-empty? dq-val))
               (< (vector-ref prefix-weights (deque-front dq-val))
                  (- (vector-ref prefix-weights i) max-weight)))
          (loop-max-weight (deque-pop-front dq-val))
          (set! current-dq dq-val)))

    ;; Calculate dp[i] using the best j from the front of the deque
    (let ([j-star (deque-front current-dq)])
      (vector-set! dp i
                   (+ 2 (vector-ref port-diffs i) ; This is port_change_count[i]
                      (- (vector-ref dp j-star) (vector-ref port-diffs (+ j-star 1)))))) ; This is port_change_count[j+1]

    ;; Add i to the deque for future calculations if it's not the final answer
    (when (< i n)
      ;; Maintain monotonic queue property for adding i
      ;; Remove j from back of dq if dp[j] - port-diffs[j+1] >= dp[i] - port-diffs[i+1]
      (let loop-monotonic ([dq-val current-dq])
        (if (and (not (deque-empty? dq-val))
                 (>= (- (vector-ref dp (deque-back dq-val)) (vector-ref port-diffs (+ (deque-back dq-val) 1)))
                     (- (vector-ref dp i) (vector-ref port-diffs (+ i 1)))))
            (loop-monotonic (deque-pop-back dq-val))
            (set! current-dq dq-val)))
      (set! current-dq (deque-push-back current-dq i))))

  (vector-ref dp n))