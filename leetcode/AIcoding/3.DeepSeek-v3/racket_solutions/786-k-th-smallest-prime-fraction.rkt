(define/contract (kth-smallest-prime-fraction arr k)
  (-> (listof exact-integer?) exact-integer? (listof exact-integer?))
  (let* ([n (length arr)]
         [left 0]
         [right 1])
    (let loop ([left left] [right right])
      (let* ([mid (/ (+ left right) 2)]
             [count 0]
             [max-frac (list 0 1)]
             [j 1])
        (for ([i (in-range (- n 1))])
          (set! j (for/fold ([j j]) ([_ (in-naturals)])
                    (if (or (>= j n) (> (* (list-ref arr i) right) (* (list-ref arr j) left)))
                        (break j)
                        (add1 j))))
          (set! count (+ count (- n j)))
          (when (< j n)
            (let ([current-frac (list (list-ref arr i) (list-ref arr j))])
              (when (> (* (car max-frac) (cadr current-frac)) (* (car current-frac) (cadr max-frac)))
                (set! max-frac current-frac)))))
        (cond
          [(= count k) max-frac]
          [(< count k) (loop mid right)]
          [else (loop left mid)])))))