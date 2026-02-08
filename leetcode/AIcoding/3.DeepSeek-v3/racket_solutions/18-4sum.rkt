(define/contract (four-sum nums target)
  (-> (listof exact-integer?) exact-integer? (listof (listof exact-integer?)))
  (let ([nums (sort nums <)]
        [n (length nums)]
        [res '()])
    (for ([i (in-range (- n 3))])
      (when (or (zero? i) (not (= (list-ref nums i) (list-ref nums (- i 1)))))
        (for ([j (in-range (+ i 1) (- n 2))])
          (when (or (= j (+ i 1)) (not (= (list-ref nums j) (list-ref nums (- j 1)))))
            (let ([left (+ j 1)]
                  [right (- n 1)]
                  [sum (- target (list-ref nums i) (list-ref nums j))])
              (while (< left right)
                (let ([total (+ (list-ref nums left) (list-ref nums right))])
                  (cond
                    [(< total sum) (set! left (+ left 1))]
                    [(> total sum) (set! right (- right 1))]
                    [else
                     (set! res (cons (list (list-ref nums i) (list-ref nums j) (list-ref nums left) (list-ref nums right)) res))
                     (set! left (+ left 1))
                     (while (and (< left right) (= (list-ref nums left) (list-ref nums (- left 1))))
                       (set! left (+ left 1)))
                     (set! right (- right 1))
                     (while (and (< left right) (= (list-ref nums right) (list-ref nums (+ right 1))))
                       (set! right (- right 1))))])))))))
    (reverse res)))