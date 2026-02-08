(define (special-array-ii nums queries)
  (let* ((n (length nums))
         (nums-vec (list->vector nums))
         (violations-list '()))

    ;; Precompute violations
    (when (> n 1)
      (for ((j (in-range (- n 1))))
        (when (= (modulo (vector-ref nums-vec j) 2)
                 (modulo (vector-ref nums-vec (+ j 1)) 2))
          (set! violations-list (cons j violations-list)))))

    (define violations-vec (list->vector (reverse violations-list)))

    ;; Binary search function to find the index of the first element >= target
    (define (binary-search-left vec target)
      (let loop ((low 0) (high (vector-length vec)) (ans (vector-length vec)))
        (if (< low high)
            (let* ((mid (quotient (+ low high) 2))
                   (val (vector-ref vec mid)))
              (if (>= val target)
                  (loop low mid mid) ; Potential answer, try left half
                  (loop (+ mid 1) high ans))) ; Too small, try right half
            ans)))

    ;; Process queries
    (map (lambda (query)
           (let* ((xi (list-ref query 0))
                  (yi (list-ref query 1))
                  (idx (binary-search-left violations-vec xi)))
             ;; If idx is a valid index AND the violation at idx is within the query range [xi, yi)
             ;; then the subarray is NOT special. Otherwise, it IS special.
             (not (and (< idx (vector-length violations-vec))
                       (< (vector-ref violations-vec idx) yi)))))
         queries)))