(define/contract (dominant-index nums)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([max-num (apply max nums)]
         [max-idx (index-of nums max-num)]
         [other-nums (remove max-num nums)])
    (if (andmap (lambda (x) (>= max-num (* 2 x))) other-nums)
        max-idx
        -1)))