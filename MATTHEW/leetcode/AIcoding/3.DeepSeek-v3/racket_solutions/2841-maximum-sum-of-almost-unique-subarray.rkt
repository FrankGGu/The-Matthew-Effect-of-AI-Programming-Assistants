(define/contract (max-sum nums m k)
  (-> (listof exact-integer?) exact-integer? exact-integer? exact-integer?)
  (define n (length nums))
  (define max-sum 0)
  (define freq (make-hash))
  (define unique 0)
  (define current-sum 0)
  (define left 0)

  (for ([right (in-range n)])
    (define num (list-ref nums right))
    (hash-update! freq num (lambda (v) (+ v 1)) (when (= (hash-ref freq num) 1) (set! unique (+ unique 1)))
    (set! current-sum (+ current-sum num))

    (when (>= (- right left) k)
      (define left-num (list-ref nums left))
      (hash-update! freq left-num (lambda (v) (- v 1))) (when (= (hash-ref freq left-num) 0) (set! unique (- unique 1)))
      (set! current-sum (- current-sum left-num))
      (set! left (+ left 1)))

    (when (and (>= (- right left -1) k) (>= unique m))
      (set! max-sum (max max-sum current-sum)))

  max-sum)