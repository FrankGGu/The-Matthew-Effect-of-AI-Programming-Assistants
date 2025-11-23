(define/contract (set-zeroes matrix)
  (-> (listof (listof exact-integer?)) void?)
  (let* ([rows (length matrix)]
         [cols (if (null? matrix) 0 (length (car matrix)))]
         [zero-rows (make-hash)]
         [zero-cols (make-hash)])
    (for ([i (in-range rows)])
      (for ([j (in-range cols)])
        (when (zero? (list-ref (list-ref matrix i) j))
          (hash-set! zero-rows i #t)
          (hash-set! zero-cols j #t))))
    (for ([i (in-range rows)])
      (for ([j (in-range cols)])
        (when (or (hash-has-key? zero-rows i) (hash-has-key? zero-cols j))
          (list-set! (list-ref matrix i) j 0))))))