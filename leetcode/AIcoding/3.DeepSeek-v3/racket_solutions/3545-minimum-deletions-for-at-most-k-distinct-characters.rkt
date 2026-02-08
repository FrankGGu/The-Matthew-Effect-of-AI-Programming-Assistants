(define/contract (minimum-deletions s k)
  (-> string? exact-integer? exact-integer?)
  (let* ([freq (make-hash)]
         [n (string-length s)]
         [left 0]
         [result +inf.0]
         [distinct 0])
    (for ([right (in-range n)])
      (let ([c (string-ref s right)])
        (hash-update! freq c (lambda (v) (+ v 1)) 0)
        (when (= (hash-ref freq c) 1)
          (set! distinct (+ distinct 1)))
        (while (> distinct k)
          (let ([c-left (string-ref s left)])
            (hash-update! freq c-left (lambda (v) (- v 1)))
            (when (= (hash-ref freq c-left) 0)
              (hash-remove! freq c-left)
              (set! distinct (- distinct 1)))
            (set! left (+ left 1)))))
        (when (<= distinct k)
          (set! result (min result (- n (- right left 1)))))))
    (if (= result +inf.0) 0 result)))