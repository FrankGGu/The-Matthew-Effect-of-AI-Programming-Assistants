(require racket/hash)
(require racket/list)

(define (relative-sort-array arr1 arr2)
  (define counts (make-hash))
  (for-each (lambda (x)
              (hash-update! counts x add1 0))
            arr1)

  (define result-parts-in-order
    (for/list ([x arr2])
      (let ([count (hash-ref counts x 0)])
        (when (> count 0)
          (hash-set! counts x 0)
          (build-list count (lambda (i) x))))))

  (define result-in-order (apply append (filter identity result-parts-in-order)))

  (define remaining-elements-parts '())
  (hash-for-each (lambda (k v)
                   (when (> v 0)
                     (set! remaining-elements-parts (cons (build-list v (lambda (i) k)) remaining-elements-parts))))
                 counts)

  (define all-remaining-elements (apply append remaining-elements-parts))

  (define sorted-remaining (sort all-remaining-elements <))

  (append result-in-order sorted-remaining))