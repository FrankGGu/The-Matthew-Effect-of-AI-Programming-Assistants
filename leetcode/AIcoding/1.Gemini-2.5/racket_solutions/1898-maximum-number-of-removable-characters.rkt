(define (maximum-removable s p removable)
  (define s-len (string-length s))
  (define p-len (string-length p))
  (define rem-len (length removable))

  (define (check k)
    (define removed-indices (make-vector s-len #f))
    (for ([i (in-range k)])
      (vector-set! removed-indices (list-ref removable i) #t))

    (let loop ((s-idx 0) (p-idx 0))
      (cond
        [(= p-idx p-len) #t]
        [(= s-idx s-len) #f]
        [else
         (if (and (not (vector-ref removed-indices s-idx))
                  (char=? (string-ref s s-idx) (string-ref p p-idx)))
             (loop (+ s-idx 1) (+ p-idx 1))
             (loop (+ s-idx 1) p-idx))])))

  (define low 0)
  (define high rem-len)
  (define ans 0)

  (let bin-search-loop ()
    (when (<= low high)
      (define mid (+ low (quotient (- high low) 2)))
      (if (check mid)
          (begin (set! ans mid)
                 (set! low (+ mid 1)))
          (begin (set! high (- mid 1)))))
    (if (<= low high) (bin-search-loop)))

  ans)