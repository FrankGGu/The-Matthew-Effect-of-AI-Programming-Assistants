(define/contract (find-diagonal-order nums)
  (-> (listof (listof exact-integer?)) (listof exact-integer?))
  (let* ([groups (make-hash)]
         [max-sum 0])
    (for ([(row i) (in-indexed nums)])
      (for ([(val j) (in-indexed row)])
        (let ([sum (+ i j)])
          (hash-update! groups sum (lambda (lst) (cons val lst)) '())
          (set! max-sum (max max-sum sum)))))
    (let loop ([sum 0]
               [result '()])
      (if (> sum max-sum)
          (reverse result)
          (loop (add1 sum) (append (reverse (hash-ref groups sum '())) result))))))