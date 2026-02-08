#lang racket

(define MOD 1000000007)
(define MAX_N 100001) ; Max n is 10^5, so we need factorials up to 10^5

(define fact (make-vector MAX_N))
(define inv-fact (make-vector MAX_N))

(define (pow base exp m)
  (let loop ((b (remainder base m))
             (e exp)
             (res 1))
    (cond
      ((zero? e) res)
      ((odd? e) (loop (remainder (* b b) m) (quotient e 2) (remainder (* res b) m)))
      (else (loop (remainder (* b b) m) (quotient e 2) res)))))

(define (mod-inv n m)
  (pow n (- m 2) m))

(define (precompute-factorials)
  (vector-set! fact 0 1)
  (vector-set! inv-fact 0 1)
  (for ((i (in-range 1 MAX_N)))
    (vector-set! fact i (remainder (* (vector-ref fact (- i 1)) i) MOD)))

  (vector-set! inv-fact (- MAX_N 1) (mod-inv (vector-ref fact (- MAX_N 1)) MOD))
  (for ((i (in-range (- MAX_N 2) 0 -1))) ; Iterate down to 1
    (vector-set! inv-fact i (remainder (* (vector-ref inv-fact (+ i 1)) (+ i 1)) MOD))))

(precompute-factorials)

(define (count-infection-sequences n sick)
  (let* ((k (length sick))
         (healthy-cells (- n k)))

    ;; If there are no healthy cells, there's only one sequence (the initial state)
    (when (zero? healthy-cells)
      (if (zero? n) ; If n is 0, sick must also be empty. This case is not allowed by constraints (n >= 1)
          (error "n cannot be 0 if sick is empty")
          1))

    (let ((ans (vector-ref fact healthy-cells))
          (middle-segment-power-factor 1))

      ;; Calculate length of the leftmost segment (cells before sick[0])
      (let ((len-left (list-ref sick 0)))
        (set! ans (remainder (* ans (vector-ref inv-fact len-left)) MOD)))

      ;; Iterate through middle segments (between sick[i-1] and sick[i])
      (for ((i (in-range 1 k)))
        (let* ((len-middle (- (list-ref sick i) (list-ref sick (- i 1)) 1)))
          (set! ans (remainder (* ans (vector-ref inv-fact len-middle)) MOD))
          (when (> len-middle 0)
            (set! middle-segment-power-factor
                  (remainder (* middle-segment-power-factor (pow 2 (- len-middle 1) MOD)) MOD)))))

      ;; Calculate length of the rightmost segment (cells after sick[k-1])
      (let ((len-right (- n (list-ref sick (- k 1)) 1)))
        (set! ans (remainder (* ans (vector-ref inv-fact len-right)) MOD)))

      ;; Multiply by the accumulated power of 2 factors for middle segments
      (remainder (* ans middle-segment-power-factor) MOD))))