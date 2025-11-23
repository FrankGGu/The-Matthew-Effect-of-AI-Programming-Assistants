(define (min-operations s1 s2 k)
  (let* ([n (string-length s1)]
         [diffs (for/list ([i (in-range n)]
                           #:when (not (equal? (string-ref s1 i) (string-ref s2 i))))
                    i)])
    (if (empty? diffs)
        0
        (let loop ([idx 0] [count 0])
          (cond
            [(>= idx (length diffs)) count]
            [(>= (+ (list-ref diffs idx) k -1) (if (< (+ idx 1) (length diffs)) (list-ref diffs (+ idx 1)) n))]
            [else (loop (+ idx 2) (+ count 1))])))))