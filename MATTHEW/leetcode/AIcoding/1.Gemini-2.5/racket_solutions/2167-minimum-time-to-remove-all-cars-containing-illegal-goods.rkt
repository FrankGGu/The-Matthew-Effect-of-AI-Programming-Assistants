(define (minimum-time s prices)
  (define n (string-length s))

  ; Check if there are any '1's. If not, the cost is 0.
  (define has-ones? #f)
  (for ([i (in-range n)])
    (when (char=? (string-ref s i) #\1)
      (set! has-ones? #t)))
  (unless has-ones?
    0) ; No '1's, no cost

  ; dp-left[i] stores the minimum cost to remove all '1's in the prefix s[0...i].
  (define dp-left (make-vector n 0))
  ; dp-right[i] stores the minimum cost to remove all '1's in the suffix s[i...n-1].
  (define dp-right (make-vector n 0))

  ; Calculate dp-left values
  ; For each car i, we have two options to ensure s[0...i] has no '1's:
  ; 1. Process car i: If s[i] is '1', pay prices[i] and add to dp-left[i-1]. If s[i] is '0', just use dp-left[i-1].
  ; 2. Remove all cars from 0 to i: This costs i + 1.
  (for ([i (in-range n)])
    (define prev-left-cost (if (> i 0) (vector-ref dp-left (- i 1)) 0))
    (define cost-if-process-i-individually
      (if (char=? (string-ref s i) #\1)
          (+ prev-left-cost (vector-ref prices i))
          prev-left-cost))
    (define cost-if-chop-left-to-i (+ i 1))
    (vector-set! dp-left i (min cost-if-process-i-individually cost-if-chop-left-to-i)))

  ; Calculate dp-right values
  ; For each car i (from right to left), we have two options to ensure s[i...n-1] has no '1's:
  ; 1. Process car i: If s[i] is '1', pay prices[i] and add to dp-right[i+1]. If s[i] is '0', just use dp-right[i+1].
  ; 2. Remove all cars from i to n-1: This costs n - i.
  (for ([i (in-range (- n 1) -1 -1)]) ; Iterate from n-1 down to 0
    (define prev-right-cost (if (< i (- n 1)) (vector-ref dp-right (+ i 1)) 0))
    (define cost-if-process-i-individually
      (if (char=? (string-ref s i) #\1)
          (+ prev-right-cost (vector-ref prices i))
          prev-right-cost))
    (define cost-if-chop-right-from-i (- n i))
    (vector-set! dp-right i (min cost-if-process-i-individually cost-if-chop-right-from-i)))

  ; The minimum total cost is found by considering all possible split points.
  ; A split point `i` means cars s[0...i] are handled by dp-left strategy,
  ; and cars s[i+1...n-1] are handled by dp-right strategy.
  ; We also need to consider cases where all cars are handled by dp-left (i.e., dp-left[n-1] + 0)
  ; or all cars are handled by dp-right (i.e., 0 + dp-right[0]).

  ; Initialize min-total-cost with the case where all '1's are cleared by the dp-left strategy.
  (define min-total-cost (vector-ref dp-left (- n 1)))

  ; Update min-total-cost with the case where all '1's are cleared by the dp-right strategy.
  (set! min-total-cost (min min-total-cost (vector-ref dp-right 0)))

  ; Iterate through all intermediate split points (i.e., i from 0 to n-2)
  ; where s[0...i] is handled by dp-left and s[i+1...n-1] by dp-right.
  (for ([i (in-range (- n 1))])
    (set! min-total-cost (min min-total-cost (+ (vector-ref dp-left i) (vector-ref dp-right (+ i 1))))))

  min-total-cost)