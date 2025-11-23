(define/contract (num-equivalent-domino-pairs dominoes)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (define domino-count (make-hash))
  (for ([dom dominoes])
    (let* ([a (car dom)]
           [b (cadr dom)]
           [key (if (< a b) (cons a b) (cons b a))])
      (hash-update! domino-count key (lambda (v) (+ v 1)) 0)))
  (let ([total 0])
    (for ([(k v) (in-hash domino-count)])
      (set! total (+ total (/ (* v (- v 1)) 2))))
    total))