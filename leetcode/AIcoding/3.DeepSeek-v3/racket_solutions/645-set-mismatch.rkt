(define/contract (find-error-nums nums)
  (-> (listof exact-integer?) (listof exact-integer?))
  (let* ([n (length nums)]
         [counts (make-hash)]
         [duplicate -1]
         [missing -1])
    (for ([num nums])
      (hash-update! counts num add1 0))
    (for ([i (in-range 1 (add1 n))])
      (cond
        [(= (hash-ref counts i 0) 2) (set! duplicate i)]
        [(= (hash-ref counts i 0) 0) (set! missing i)]))
      #:break (and (not (= duplicate -1)) (not (= missing -1))))
    (list duplicate missing)))