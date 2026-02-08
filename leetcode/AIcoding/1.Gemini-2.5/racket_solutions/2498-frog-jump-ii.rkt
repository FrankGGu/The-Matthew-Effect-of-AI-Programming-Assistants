#lang racket

(define (frog-jump-ii stones)
  (define n (vector-length stones))

  (define (check max-jump)
    (let outer-loop ((current-stone-idx 0))
      (if (>= current-stone-idx (- n 1))
          #t
          (let inner-loop ((next-idx (+ current-stone-idx 1))
                           (furthest-jump-target current-stone-idx))
            (cond
              ((>= next-idx n)
               (if (= furthest-jump-target current-stone-idx)
                   #f
                   (outer-loop furthest-jump-target)))
              ((<= (- (vector-ref stones next-idx) (vector-ref stones current-stone-idx)) max-jump)
               (inner-loop (+ next-idx 1) next-idx))
              (else
               (if (= furthest-jump-target current-stone-idx)
                   #f
                   (outer-loop furthest-jump-target))))))))

  (let bin-search ((low 0) (high (- (vector-ref stones (- n 1)) (vector-ref stones 0))))
    (if (> low high)
        low
        (let ((mid (quotient (+ low high) 2)))
          (if (check mid)
              (bin-search low (- mid 1))
              (bin-search (+ mid 1) high))))))