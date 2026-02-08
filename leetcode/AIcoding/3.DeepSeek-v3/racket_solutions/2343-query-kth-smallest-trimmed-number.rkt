(define/contract (smallest-trimmed-numbers nums queries)
  (-> (listof string?) (listof (listof exact-integer?)) (listof exact-integer?))
  (define (trim num k)
    (substring num (max 0 (- (string-length num) k)) k))
  (map (lambda (query)
         (let ([k (first query)]
               [trim-length (second query)])
           (let* ([trimmed (map (lambda (num) (trim num trim-length)) nums)]
                  [indexed (map list (range (length nums)) trimmed)]
                  [sorted (sort indexed (lambda (a b) (or (string<? (second a) (second b))
                                                          (and (string=? (second a) (second b))
                                                               (< (first a) (first b))))))])
             (first (list-ref sorted (sub1 k))))))
       queries))