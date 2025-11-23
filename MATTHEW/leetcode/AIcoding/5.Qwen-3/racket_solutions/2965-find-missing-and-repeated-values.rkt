(define/contract (find-missing-and-repeated-values grid n)
  (-> (listof (listof exact-integer?)) exact-integer? (values exact-integer? exact-integer?))
  (let* ([flat (apply append grid)]
         [counts (make-hash)]
         [repeated -1]
         [missing -1])
    (for-each (lambda (x)
                (hash-set! counts x (+ (hash-ref counts x 0) 1)))
              flat)
    (for ([i (in-range 1 (+ n n))])
      (if (= (hash-ref counts i 0) 2)
          (set! repeated i)
          (when (= (hash-ref counts i 0) 0)
            (set! missing i))))
    (values missing repeated)))