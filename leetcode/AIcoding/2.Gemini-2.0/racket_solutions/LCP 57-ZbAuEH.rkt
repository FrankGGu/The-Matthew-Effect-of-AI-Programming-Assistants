(define (max-score moles)
  (let* ([n (length moles)]
         [dp (make-vector n 0)])
    (vector-set! dp 0 (cdr (list-ref moles 0)))
    (for ([i (in-range 1 n)])
      (let* ([curr (list-ref moles i)]
             [time (car curr)]
             [score (cdr curr)])
        (vector-set! dp i score)
        (for ([j (in-range 0 i)])
          (let* ([prev (list-ref moles j)]
                 [prev-time (car prev)])
            (when (<= (abs (- time prev-time)) (- i j))
              (vector-set! dp i (max (vector-ref dp i) (+ (vector-ref dp j) score))))))))
    (apply max (vector->list dp))))