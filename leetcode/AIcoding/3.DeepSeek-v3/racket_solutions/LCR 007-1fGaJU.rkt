(define/contract (three-sum nums)
  (-> (listof exact-integer?) (listof (listof exact-integer?)))
  (let ([nums (sort nums <)]
        [result '()])
    (for ([i (in-range (- (length nums) 2))])
      (when (or (zero? i) (not (equal? (list-ref nums i) (list-ref nums (- i 1)))))
        (let ([left (+ i 1)]
              [right (- (length nums) 1)]
              [target (- 0 (list-ref nums i))])
          (let loop ([left left] [right right])
            (when (< left right)
              (let ([sum (+ (list-ref nums left) (list-ref nums right))])
                (cond
                  [(= sum target)
                   (set! result (cons (list (list-ref nums i) (list-ref nums left) (list-ref nums right)) result))
                   (let ([left-val (list-ref nums left)]
                         [right-val (list-ref nums right)])
                     (loop (let loop-left ([l (+ left 1)])
                             (if (and (< l (length nums)) (= (list-ref nums l) left-val))
                                 (loop-left (+ l 1))
                                 l))
                           (let loop-right ([r (- right 1)])
                             (if (and (>= r 0) (= (list-ref nums r) right-val))
                                 (loop-right (- r 1))
                                 r))))]
                  [(< sum target)
                   (loop (+ left 1) right)]
                  [else
                   (loop left (- right 1))])))))))
    (reverse result)))