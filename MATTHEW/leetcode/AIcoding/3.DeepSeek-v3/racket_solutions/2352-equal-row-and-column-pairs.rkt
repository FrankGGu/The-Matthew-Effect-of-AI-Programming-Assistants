(define/contract (equal-pairs grid)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (define n (length grid))
  (define rows (make-hash))
  (define cols (make-hash))

  (for ([row grid])
    (hash-update! rows row (lambda (v) (+ v 1)) 0))

  (for ([j (in-range n)])
    (define col (for/list ([i (in-range n)]) (list-ref (list-ref grid i) j)))
    (hash-update! cols col (lambda (v) (+ v 1)) 0))

  (define count 0)
  (hash-for-each rows (lambda (k v) (set! count (+ count (* v (hash-ref cols k 0))))))
  count)