(define/contract (is-possible nums)
  (-> (listof exact-integer?) boolean?)
  (let ((freq (make-hash))
        (need (make-hash)))
    (for ([num nums])
      (hash-update! freq num add1 0))
    (for ([num nums])
      (cond
        [(= (hash-ref freq num 0) 0]
        [(> (hash-ref need num 0) 0)
         (hash-update! need num sub1)
         (hash-update! need (+ num 1) add1 0)
         (hash-update! freq num sub1)]
        [(and (> (hash-ref freq (+ num 1) 0) (> (hash-ref freq (+ num 2) 0)))
              (hash-update! freq num sub1)
              (hash-update! freq (+ num 1) sub1)
              (hash-update! freq (+ num 2) sub1)
              (hash-update! need (+ num 3) add1 0)]
        [else #f]))
    #t))