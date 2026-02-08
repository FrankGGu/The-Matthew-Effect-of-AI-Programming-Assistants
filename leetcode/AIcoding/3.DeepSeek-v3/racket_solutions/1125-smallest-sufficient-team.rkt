(define/contract (smallest-sufficient-team req_skills people)
  (-> (listof string?) (listof (listof string?)) (listof exact-integer?))
  (let* ([skill-index (make-hash)]
         [n (length req_skills)]
         [target (sub1 (expt 2 n))]
         [dp (make-hash (list (cons 0 '())))])

    (for ([skill req_skills] [i (in-range n)])
      (hash-set! skill-index skill i))

    (for ([(person-skills person-id) (in-indexed people)])
      (let ([person-mask 0])
        (for ([skill person-skills])
          (set! person-mask (bitwise-ior person-mask (expt 2 (hash-ref skill-index skill)))))
        (hash-for-each dp
          (lambda (mask team)
            (let ([new-mask (bitwise-ior mask person-mask)])
              (when (or (not (hash-has-key? dp new-mask))
                      (< (+ 1 (length team)) (length (hash-ref dp new-mask (lambda () (make-list (add1 (length people)) #f))))))
                (hash-set! dp new-mask (cons person-id team))))))))

    (reverse (hash-ref dp target))))