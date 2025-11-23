(define/contract (min-operations nums)
  (-> (listof exact-integer?) exact-integer?)
  (let ((freq (make-hash)))
    (for ([num nums])
      (hash-update! freq num add1 0))
    (let loop ([count 0] [remaining (hash->list freq)])
      (if (null? remaining)
          count
          (let* ([pair (car remaining)]
                 [num (car pair)]
                 [freq (cdr pair)])
            (cond
              [(= freq 1) -1]
              [(= (modulo freq 3) 0) (loop (+ count (/ freq 3)) (cdr remaining))]
              [else (loop (+ count (quotient (+ freq 3) 3)) (cdr remaining))]))))))