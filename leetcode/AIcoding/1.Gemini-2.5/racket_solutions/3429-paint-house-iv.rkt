(define (paint-house-iv houses cost target)
  (define n (vector-length houses))
  (define m (vector-length (vector-ref cost 0))) ; m is number of colors

  ; A large enough number to represent infinity. Max possible cost is 100 * 10000 = 1,000,000.
  (define +inf.0 (expt 10 9))

  ; dp[i][j][k] = minimum cost to paint houses 0..i, where house i is painted
  ; with color j (0-indexed, so actual color is j+1), and k neighborhoods
  ; are formed up to house i.
  ; dp is a vector of vectors of vectors.
  (define dp (make-vector n))
  (for ([i (in-range n)])
    (vector-set! dp i (make-vector m)))
  (for ([i (in-range n)])
    (for ([j (in-range m)])
      (vector-set! (vector-ref dp i) j (make-vector (+ target 1) +inf.0))))

  ; Base case: house 0
  (define house0-color (vector-ref houses 0))
  (if (= house0-color 0) ; If house 0 is unpainted
      (for ([j (in-range m)]) ; Try all colors for house 0
        (vector-set! (vector-ref (vector-ref dp 0) j) 1 (vector-ref (vector-ref cost 0) j)))
      ; If house 0 is already painted
      (vector-set! (vector-ref (vector-ref dp 0) (- house0-color 1)) 1 0)) ; Cost is 0, color is house0-color-1 (0-indexed)

  ; DP transitions for houses 1 to n-1
  (for ([i (in-range 1 n)]) ; Current house index
    (define current-house-color (vector-ref houses i))
    (for ([j (in-range m)]) ; Current house's color (0-indexed, so j+1 is actual color)
      ; Calculate the cost to paint current house i with color j+1
      (define cost-to-paint-current (if (= current-house-color 0) (vector-ref (vector-ref cost i) j) 0))

      ; Only proceed if house i can be painted with color j+1 (either unpainted or already has this color)
      (when (or (= current-house-color 0) (= current-house-color (+ j 1)))
        (for ([k (in-range 1 (+ target 1))]) ; Number of neighborhoods formed up to house i (from 1 to target)
          (for ([prev-j (in-range m)]) ; Previous house's color (0-indexed)
            (if (= prev-j j) ; If current house color is same as previous house color
                ; Same neighborhood count as previous state
                (let ([prev-dp-val (vector-ref (vector-ref (vector-ref dp (- i 1)) prev-j) k)])
                  (when (< prev-dp-val +inf.0)
                    (vector-set! (vector-ref (vector-ref dp i) j) k
                                 (min (vector-ref (vector-ref (vector-ref dp i) j) k)
                                      (+ prev-dp-val cost-to-paint-current)))))
                ; If current house color is different from previous house color, a new neighborhood is formed
                (when (> k 1) ; This requires at least 2 neighborhoods to be formed (1 from previous, 1 new)
                  (let ([prev-dp-val-minus-one-neighborhood (vector-ref (vector-ref (vector-ref dp (- i 1)) prev-j) (- k 1))])
                    (when (< prev-dp-val-minus-one-neighborhood +inf.0)
                      (vector-set! (vector-ref (vector-ref dp i) j) k
                                   (min (vector-ref (vector-ref (vector-ref dp i) j) k)
                                        (+ prev-dp-val-minus-one-neighborhood cost-to-paint-current)))))))))))

  ; Find the minimum cost for the last house (n-1) with 'target' neighborhoods
  (define min-final-cost +inf.0)
  (for ([j (in-range m)])
    (set! min-final-cost (min min-final-cost (vector-ref (vector-ref (vector-ref dp (- n 1)) j) target))))

  ; If min-final-cost is still infinity, it's impossible to achieve the target, return -1
  (if (= min-final-cost +inf.0)
      -1
      min-final-cost))