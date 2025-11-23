(define (rearrange-characters s target)
  (let* ([s-counts (make-hash)]
         [target-counts (make-hash)]
         [s-len (string-length s)]
         [target-len (string-length target)])

    (for ([i (in-range s-len)])
      (let ([char (string-ref s i)])
        (hash-update! s-counts char (λ (v) (+ v 1)) 1)))

    (for ([i (in-range target-len)])
      (let ([char (string-ref target i)])
        (hash-update! target-counts char (λ (v) (+ v 1)) 1)))

    (let loop ([min-count #f])
      (let ([can-make? (for/and ([char (in-list (hash-keys target-counts))])
                         (and (hash-has-key? s-counts char)
                              (>= (hash-ref s-counts char) (hash-ref target-counts char))))])
        (if can-make?
            (begin
              (for ([char (in-list (hash-keys target-counts))])
                (hash-update! s-counts char (λ (v) (- v (hash-ref target-counts char))) 0))
              (loop (if min-count (+ min-count 1) 1)))
            (or min-count 0))))))