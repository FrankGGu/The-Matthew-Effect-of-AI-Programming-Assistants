#lang racket

(define/contract (max-hourglass matrix)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (let* ([rows (length matrix)]
         [cols (if (null? matrix) 0 (length (car matrix)))]
         [max-sum -inf.0])
    (for ([i (in-range 1 (- rows 1))])
      (for ([j (in-range 1 (- cols 1))])
        (let* ([top (list-ref (list-ref matrix i) j)]
               [middle (list-ref (list-ref matrix (sub1 i)) j)]
               [bottom (list-ref (list-ref matrix (add1 i)) j)]
               [sum (+ top middle bottom
                        (list-ref (list-ref matrix (sub1 i)) (sub1 j))
                        (list-ref (list-ref matrix (sub1 i)) (add1 j))
                        (list-ref (list-ref matrix (add1 i)) (sub1 j))
                        (list-ref (list-ref matrix (add1 i)) (add1 j)))])
          (set! max-sum (max max-sum sum)))))
    max-sum))