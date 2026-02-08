(require racket/hash)

(define (find-number-of-copy-arrays arrays)
  (define counts (make-hash))

  (for-each
   (lambda (arr)
     (hash-update! counts arr (lambda (val) (add1 (or val 0))) 0))
   arrays)

  (define total-copies 0)
  (hash-for-each
   counts
   (lambda (arr count)
     (when (> count 1)
       (set! total-copies (+ total-copies (- count 1)))))
   )
  total-copies)