(define (topKFrequent nums k)
  (define freq-map (make-hash))
  (for-each (lambda (num)
              (hash-update! freq-map num (lambda (x) (+ x 1)) 0))
            nums)
  (define sorted (sort (hash->list freq-map) (lambda (a b) (> (cdr a) (cdr b)))))
  (map car (take sorted k)))

(topKFrequent '(1 1 1 2 2 3) 2)