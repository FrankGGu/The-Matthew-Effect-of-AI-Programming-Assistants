(define (two-sum nums target)
  (define hash (make-hash))
  (for ([i (in-range (length nums))])
    (let ([complement (- target (list-ref nums i))])
      (if (hash-has-key? hash complement)
          (begin
            (display (list (hash-ref hash complement) i))
            (exit)))
      (hash-set! hash (list-ref nums i) i))))