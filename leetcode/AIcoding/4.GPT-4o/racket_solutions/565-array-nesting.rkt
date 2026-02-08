(define (arrayNesting nums)
  (define (dfs visited idx)
    (if (or (vector-ref visited idx) (vector-ref nums idx) #f)
        0
        (begin
          (vector-set! visited idx #t)
          (+ 1 (dfs visited (vector-ref nums idx)))))
  (define visited (make-vector (length nums) #f))
  (define max-length 0)
  (for-each
    (lambda (i)
      (set! max-length (max max-length (dfs visited i))))
    (range (length nums)))
  max-length)

(arrayNesting (vector 5 4 0 3 1 6 2))