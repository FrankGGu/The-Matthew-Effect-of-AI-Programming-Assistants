(define/contract (majority-element nums)
  (-> (listof exact-integer?) (listof exact-integer?))
  (let* ([n (length nums)]
         [threshold (floor (/ n 3))]
         [counts (make-hash)])
    (for ([num nums])
      (hash-update! counts num add1 0))
    (filter (lambda (x) (> (hash-ref counts x) threshold)) (hash-keys counts)))