(define (get-power x)
  (let loop ([x x] [steps 0])
    (cond
      [(= x 1) steps]
      [(even? x) (loop (/ x 2) (add1 steps))]
      [else (loop (+ (* 3 x) 1) (add1 steps))])))

(define (get-kth lo hi k)
  (define lst (build-list (- hi lo -1) (lambda (i) (+ lo i))))
  (define sorted (sort lst (lambda (a b)
                             (let ([pa (get-power a)]
                                   [pb (get-power b)])
                               (or (< pa pb)
                                   (and (= pa pb) (< a b)))))))
  (list-ref sorted (sub1 k)))