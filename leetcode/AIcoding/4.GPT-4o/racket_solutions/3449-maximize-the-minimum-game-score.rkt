(define (maximize-the-minimum nums)
  (define (can-achieve-minimum x)
    (let loop ((i 0) (count 0))
      (cond
        ((>= i (length nums)) (>= count (/ (length nums) 2)))
        ((>= (list-ref nums i) x) (loop (+ i 2) (+ count 1)))
        (else (loop (+ i 1) count)))))

  (define (binary-search lo hi)
    (if (>= lo hi)
        lo
        (let ((mid (quotient (+ lo hi) 2)))
          (if (can-achieve-minimum mid)
              (binary-search mid hi)
              (binary-search lo mid)))))

  (binary-search 1 (apply max nums)))

(maximize-the-minimum '(3 5 1 2 4))