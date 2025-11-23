#lang racket

(define (find-k-th-smallest-pair-distance nums k)
  (define n (length nums))
  (define (count-pairs-dists less-than)
    (let loop ([i 0] [j 1] [count 0])
      (cond [(>= i n) count]
            [(>= j n) (loop (+ i 1) (+ i 2) count)]
            [(<= (- (list-ref nums j) (list-ref nums i)) less-than)
             (loop i (+ j 1) (+ count (- j i)))]
            [else (loop (+ i 1) (+ i 2) count)])))
  (define sorted-nums (sort nums <))
  (let ([low 0] [high (- (last sorted-nums) (first sorted-nums))])
    (let loop ([low low] [high high])
      (if (> low high)
          low
          (let ([mid (quotient (+ low high) 2)])
            (if (< (count-pairs-dists mid) k)
                (loop (+ mid 1) high)
                (loop low (- mid 1))))))))