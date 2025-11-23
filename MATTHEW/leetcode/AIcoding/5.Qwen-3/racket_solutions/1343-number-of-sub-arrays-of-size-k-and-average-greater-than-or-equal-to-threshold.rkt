(define (num-of-subarrays k threshold arr)
  (define n (length arr))
  (define target (* k threshold))
  (define sum (apply + (take arr k)))
  (define (helper i count current-sum)
    (if (>= i (- n k))
        count
        (let* ([next-sum (+ current-sum (- (list-ref arr (+ i k)) (list-ref arr i)))]
               [new-count (if (>= next-sum target) (+ count 1) count)])
          (helper (+ i 1) new-count next-sum))))
  (helper 0 (if (>= sum target) 1 0) sum))