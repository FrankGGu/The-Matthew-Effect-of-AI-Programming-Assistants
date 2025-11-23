#lang racket

(define (get-rhombus-sum grid r c s)
  (if (= s 0)
      ;; For size 0, it's just the value of the center cell
      (vector-ref (vector-ref grid r) c)
      ;; For s > 0, calculate the sum of the perimeter
      (let ()
        ;; Segment 1: From top corner (r-s, c) to right corner (r, c+s)
        ;; Points are (r-s+k, c+k) for k from 0 to s
        (define sum1 (for/sum ((k (in-range 0 (+ s 1))))
                       (vector-ref (vector-ref grid (- r s k)) (+ c k))))

        ;; Segment 2: From right corner (r, c+s) to bottom corner (r+s, c)
        ;; Points are (r+k, c+s-k) for k from 0 to s
        ;; Start k from 1 to avoid double-counting the right corner (r, c+s)
        (define sum2 (for/sum ((k (in-range 1 (+ s 1))))
                       (vector-ref (vector-ref grid (+ r k)) (- c s k))))

        ;; Segment 3: From bottom corner (r+s, c) to left corner (r, c-s)
        ;; Points are (r+s-k, c-k) for k from 0 to s
        ;; Start k from 1 to avoid double-counting the bottom corner (r+s, c)
        (define sum3 (for/sum ((k (in-range 1 (+ s 1))))
                       (vector-ref (vector-ref grid (- (+ r s) k)) (- c k))))

        ;; Segment 4: From left corner (r, c-s) to top corner (r-s, c)
        ;; Points are (r-k, c-s+k) for k from 0 to s
        ;; Start k from 1 to avoid double-counting the left corner (r, c-s)
        ;; End k at s-1 to avoid double-counting the top corner (r-s, c)
        (define sum4 (for/sum ((k (in-range 1 s)))
                       (vector-ref (vector-ref grid (- r k)) (+ (- c s) k))))

        (+ sum1 sum2 sum3 sum4))))

(define (get-biggest-three-rhombus-sums grid)
  (define m (length grid))
  (define n (length (car grid)))

  ;; Convert grid to vector of vectors for efficient indexed access
  (define grid-vec (build-vector m (lambda (r) (list->vector (list-ref grid r)))))

  ;; Use a hash-set to store unique rhombus sums
  (define sums (make-hash-set))

  ;; Iterate over all possible center cells (r, c)
  (for ((r (in-range m)))
    (for ((c (in-range n)))
      ;; Always add the sum for a rhombus of size 0 (single cell)
      (hash-set-add! sums (vector-ref (vector-ref grid-vec r) c))

      ;; Iterate over possible rhombus sizes s > 0
      ;; The maximum possible size s is limited by the grid boundaries for the current center (r, c)
      ;; A rhombus of size s centered at (r,c) requires:
      ;; r-s >= 0  => s <= r
      ;; r+s < m   => s < m-r => s <= m-1-r
      ;; c-s >= 0  => s <= c
      ;; c+s < n   => s < n-c => s <= n-1-c
      ;; So, s <= min(r, m-1-r, c, n-1-c)
      (define max-s (min r (- m 1 r) c (- n 1 c)))

      (for ((s (in-range 1 (add1 max-s))))
        (hash-set-add! sums (get-rhombus-sum grid-vec r c s)))))

  ;; Convert the set of sums to a list, sort in descending order, and take the top 3
  (define sorted-sums (sort (hash-set->list sums) >))
  (take sorted-sums 3))