#lang racket

(require data/rbl-tree)

(define (min-positive-sum-subarray nums)
  (let* ([n (length nums)]
         [prefix-sums (make-vector (+ n 1) 0)]
         [current-sum 0]
         [min-sum #f]
         [tree (rbl-tree<-> (make-rbl-tree))]
         )

    (let loop ([lst nums] [idx 0])
      (when (not (null? lst))
        (set! current-sum (+ current-sum (car lst)))
        (vector-set! prefix-sums (+ idx 1) current-sum)
        (loop (cdr lst) (+ idx 1))))

    (set! tree (rbl-tree-add tree (vector-ref prefix-sums 0)))

    (for ([j (in-range 1 (+ n 1))])
      (let* ([pj (vector-ref prefix-sums j)]
             [predecessor (rbl-tree-find-predecessor tree pj)])

        (when predecessor
          (let ([diff (- pj predecessor)])
            (when (> diff 0)
              (if (or (not min-sum) (< diff min-sum))
                  (set! min-sum diff)))))

        (set! tree (rbl-tree-add tree pj))))

    (if min-sum
        min-sum
        -1)))