(define (get-value board r c)
  (list-ref (list-ref board r) c))

(define (max-3-rook-sum-for-fixed-rows-cols board r1 r2 r3 c1 c2 c3)
  (define v11 (get-value board r1 c1))
  (define v12 (get-value board r1 c2))
  (define v13 (get-value board r1 c3))

  (define v21 (get-value board r2 c1))
  (define v22 (get-value board r2 c2))
  (define v23 (get-value board r2 c3))

  (define v31 (get-value board r3 c1))
  (define v32 (get-value board r3 c2))
  (define v33 (get-value board r3 c3))

  (define sums
    (list
     (+ v11 v22 v33)
     (+ v11 v23 v32)
     (+ v12 v21 v33)
     (+ v12 v23 v31)
     (+ v13 v21 v32)
     (+ v13 v22 v31)))
  (apply max sums))

(define (maximum-value-sum-by-placing-three-rooks board)
  (define N (length board))
  (define M (length (car board)))

  (define current-max-sum #f)

  (when (and (>= N 3) (>= M 3))
    (for* ([r1 (in-range N)]
           [r2 (in-range (+ r1 1) N)]
           [r3 (in-range (+ r2 1) N)]
           [c1 (in-range M)]
           [c2 (in-range (+ c1 1) M)]
           [c3 (in-range (+ c2 1) M)])
      (define current-sum (max-3-rook-sum-for-fixed-rows-cols board r1 r2 r3 c1 c2 c3))
      (set! current-max-sum
            (if (eq? current-max-sum #f)
                current-sum
                (max current-max-sum current-sum))))))

  (if (eq? current-max-sum #f)
      -1
      current-max-sum))