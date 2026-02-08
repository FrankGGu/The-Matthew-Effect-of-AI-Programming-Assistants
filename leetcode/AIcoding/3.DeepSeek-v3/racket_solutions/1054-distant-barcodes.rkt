(define/contract (rearrange-barcodes barcodes)
  (-> (listof exact-integer?) (listof exact-integer?))
  (define freq (make-hash))
  (for ([b barcodes])
    (hash-update! freq b add1 (lambda () 0)))
  (define heap (make-heap (lambda (a b) (> (car a) (car b)))))
  (for ([(k v) (in-hash freq)])
    (heap-add! heap (cons v k)))
  (define result '())
  (let loop ()
    (if (heap-empty? heap)
        (reverse result)
        (let* ([first (heap-remove! heap)]
               [v1 (car first)]
               [k1 (cdr first)])
          (if (heap-empty? heap)
              (cons k1 result)
              (let* ([second (heap-remove! heap)]
                     [v2 (car second)]
                     [k2 (cdr second)])
                (heap-add! heap (cons (- v2 1) k2))
                (heap-add! heap (cons (- v1 1) k1))
                (set! result (cons k2 (cons k1 result)))
                (loop)))))))