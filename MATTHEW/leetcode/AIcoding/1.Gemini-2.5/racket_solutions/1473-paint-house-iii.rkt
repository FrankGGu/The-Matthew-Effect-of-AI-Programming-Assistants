#lang racket

(define (min-cost-paint-houses houses cost target)
  (define m (vector-length houses))
  (define n (vector-length (vector-ref cost 0)))
  (define INF (expt 10 10)) ; A sufficiently large number for infinity

  ;; dp[i][j][k] = minimum cost to paint houses 0 to i,
  ;;                where house i is painted with color j (0-indexed, so color j+1),
  ;;                and there are k neighborhoods.
  ;; i: house index (0 to m-1)
  ;; j: color index (0 to n-1)
  ;; k: number of neighborhoods (1 to target)

  ;; Initialize dp table with INF
  (define dp
    (let ([outer (make-vector m #f)])
      (for ([i (in-range m)])
        (let ([middle (make-vector n #f)])
          (for ([j (in-range n)])
            (vector-set! middle j (make-vector (add1 target) INF))) ; k from 0 to target
          (vector-set! outer i middle)))
      outer))

  ;; Initialize dp table for the first house (house 0)
  (for ([j (in-range n)]) ; current_color_idx (0-indexed)
    (let ([house0-color (vector-ref houses 0)])
      (cond
        [(zero? house0-color) ; House 0 is unpainted
         (vector-set! (vector-ref (vector-ref dp 0) j) 1 (vector-ref (vector-ref cost 0) j))]
        [(= house0-color (add1 j)) ; House 0 is already painted with color j+1
         (vector-set! (vector-ref (vector-ref dp 0) j) 1 0)]
        [else ; House 0 is already painted with a different color, this dp[0][j][1] remains INF
         ])))

  ;; Fill dp table for houses from 1 to m-1
  (for ([i (in-range 1 m)]) ; current house index
    (for ([j (in-range n)]) ; current_color_idx (0-indexed)
      (let ([current-house-color (vector-ref houses i)])
        (cond
          [(and (not (zero? current-house-color))
                (not (= current-house-color (add1 j))))
           ;; House i is already painted with a different color than j+1, this state is impossible
           ]
          [else
           (let ([paint-cost (if (zero? current-house-color)
                                 (vector-ref (vector-ref cost i) j)
                                 0)])
             (for ([k (in-range 1 (add1 target))]) ; num_neighborhoods (1 to target)
               (let ([min-prev-cost INF])
                 (for ([prev-j (in-range n)]) ; prev_color_idx (0-indexed)
                   (let ([prev-color-val (add1 prev-j)]) ; prev_color (1-indexed)
                     (cond
                       [(= prev-color-val (add1 j))
                        ;; Same neighborhood as previous house
                        (set! min-prev-cost
                              (min min-prev-cost (vector-ref (vector-ref (vector-ref dp (sub1 i)) prev-j) k)))]
                       [else
                        ;; New neighborhood
                        (when (> k 1) ; Need at least 2 neighborhoods to form a new one
                          (set! min-prev-cost
                                (min min-prev-cost (vector-ref (vector-ref (vector-ref dp (sub1 i)) prev-j) (sub1 k)))))])))
                 (when (not (= min-prev-cost INF))
                   (vector-set! (vector-ref (vector-ref dp i) j) k (+ min-prev-cost paint-cost)))))]))))

  ;; Find the minimum cost for the last house with 'target' neighborhoods
  (let ([result INF])
    (for ([j (in-range n)])
      (set! result (min result (vector-ref (vector-ref (vector-ref dp (sub1 m)) j) target))))
    (if (= result INF)
        -1
        result)))