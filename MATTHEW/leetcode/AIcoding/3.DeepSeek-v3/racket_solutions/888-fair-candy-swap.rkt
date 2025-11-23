(define/contract (fair-candy-swap alice-sizes bob-sizes)
  (-> (listof exact-integer?) (listof exact-integer?) (listof exact-integer?))
  (let* ([sum-alice (apply + alice-sizes)]
         [sum-bob (apply + bob-sizes)]
         [delta (quotient (- sum-bob sum-alice) 2)]
         [bob-set (list->set bob-sizes)])
    (for/first ([a alice-sizes]
                #:when (set-member? bob-set (+ a delta)))
      (list a (+ a delta)))))