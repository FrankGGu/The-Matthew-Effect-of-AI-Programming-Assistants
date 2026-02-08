(define (max-increasing-groups: nums)
  (define (can-form-groups k)
    (>= (apply + (map (lambda (x) x) (range 1 (+ k 1)))) (length nums)))
  (define (binary-search lo hi)
    (if (>= lo hi)
        lo
        (let ((mid (quotient (+ lo hi) 2)))
          (if (can-form-groups mid)
              (binary-search lo mid)
              (binary-search (add1 mid) hi)))))
  (binary-search 0 (length nums)))

(max-increasing-groups '(1 2 3 4 5))