(define (kth-distinct arr k)
  (define counts (make-hash))

  (for-each (lambda (s)
              (hash-set! counts s (+ (hash-ref counts s 0) 1)))
            arr)

  (define distinct-count 0)
  (define found-string "")

  (for-each (lambda (s)
              (when (string=? found-string "")
                (when (= (hash-ref counts s) 1)
                  (set! distinct-count (+ distinct-count 1))
                  (when (= distinct-count k)
                    (set! found-string s)))))
            arr)
  found-string)