(define/contract (take-characters s k)
  (-> string? exact-integer? exact-integer?)
  (let* ([n (string-length s)]
         [counts (make-hash '((#\a . 0) (#\b . 0) (#\c . 0)))]
         [left 0]
         [right n]
         [result -1])
    (for ([c (in-string s)])
      (hash-update! counts c add1))
    (when (and (>= (hash-ref counts #\a) k)
               (>= (hash-ref counts #\b) k)
               (>= (hash-ref counts #\c) k))
      (set! result n))
    (let loop ([l 0] [r n] [current-counts counts])
      (when (and (< l r) (>= result 0))
      (cond
        [(and (>= (hash-ref current-counts #\a) k)
              (>= (hash-ref current-counts #\b) k)
              (>= (hash-ref current-counts #\c) k))
         (set! result (min result (- r l)))
         (loop (add1 l) r (hash-update (hash-copy current-counts) (string-ref s l) sub1))]
        [(< l r)
         (set! r (sub1 r))
         (loop l r (hash-update (hash-copy current-counts) (string-ref s r) sub1))]
        [else (void)]))
    (if (>= result 0) result -1)))