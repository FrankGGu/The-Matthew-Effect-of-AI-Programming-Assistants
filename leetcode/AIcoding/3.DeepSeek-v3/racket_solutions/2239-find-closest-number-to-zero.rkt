(define/contract (find-closest-number nums)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([abs-nums (map abs nums)]
         [min-abs (apply min abs-nums)])
    (if (member min-abs nums)
        min-abs
        (- min-abs))))