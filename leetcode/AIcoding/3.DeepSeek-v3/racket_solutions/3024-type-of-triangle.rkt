(define/contract (triangle-type nums)
  (-> (listof exact-integer?) string?)
  (let* ([a (first nums)]
         [b (second nums)]
         [c (third nums)]
         [sorted (sort nums <)])
    (cond
      [(>= (first sorted) (+ (second sorted) (third sorted))) "none"]
      [(and (= a b) (= b c)) "equilateral"]
      [(or (= a b) (= b c) (= a c)) "isosceles"]
      [else "scalene"])))