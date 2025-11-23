#lang racket

(define (rearrange-fruits basket1 basket2)
  (define total-counts (make-hash))
  (define basket1-counts (make-hash))
  (define min-val (add1 (expt 10 9))) ; Initialize with a value larger than any possible fruit value

  ;; Populate counts and find min-val
  (define (process-basket basket is-basket1?)
    (for ([fruit basket])
      (hash-update! total-counts fruit add1 0)
      (when is-basket1?
        (hash-update! basket1-counts fruit add1 0))
      (set! min-val (min min-val fruit))))

  (process-basket basket1 #t)
  (process-basket basket2 #f)

  (call/cc
   (lambda (return-from-rearrange-fruits)
     ;; Check feasibility: all total counts must be even
     (for ([(fruit count) total-counts])
       (when (odd? count)
         (return-from-rearrange-fruits -1)))

     ;; Collect excess fruits that need to move
     (define excess-fruits-to-move '())
     (for ([(fruit count) total-counts])
       (define target-count (/ count 2))
       (define b1-count (hash-ref basket1-counts fruit 0))

       ;; If basket1 has more than its target share, these are excess
       (when (> b1-count target-count)
         (define num-excess (- b1-count target-count))
         (for ([_ (in-range num-excess)])
           (set! excess-fruits-to-move (cons fruit excess-fruits-to-move))))

       ;; If basket2 has more than its target share, these are excess
       ;; (total-count - b1-count) gives b2-count
       (when (< b1-count target-count)
         (define b2-count (- count b1-count))
         (define num-excess (- b2-count target-count))
         (for ([_ (in-range num-excess)])
           (set! excess-fruits-to-move (cons fruit excess-fruits-to-move)))))

     ;; Sort the excess fruits to identify the cheapest ones to move
     (set! excess-fruits-to-move (sort excess-fruits-to-move <))

     ;; Calculate total minimum cost
     (define total-cost 0)
     ;; The number of actual swaps needed is half the total number of excess fruits
     (define num-swaps (/ (length excess-fruits-to-move) 2))

     ;; For the 'num-swaps' cheapest excess fruits, calculate the cost.
     ;; Each fruit 'f' can either be swapped directly (cost 'f') or indirectly
     ;; using the overall minimum fruit value (cost '2 * min-val').
     ;; We take the minimum of these two options for each of the 'num-swaps' fruits.
     (for ([i (in-range num-swaps)])
       (define fruit-val (list-ref excess-fruits-to-move i))
       (set! total-cost (+ total-cost (min fruit-val (* 2 min-val)))))

     total-cost)))