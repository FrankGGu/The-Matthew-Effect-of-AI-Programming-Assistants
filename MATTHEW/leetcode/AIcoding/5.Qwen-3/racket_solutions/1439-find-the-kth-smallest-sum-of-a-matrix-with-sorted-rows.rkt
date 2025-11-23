#lang racket

(define (kth-smallest matrix k)
  (define (count-less-equal target)
    (define (count-row row)
      (define (helper i cnt)
        (if (or (>= i (length row)) (>= (list-ref row i) target))
            cnt
            (helper (+ i 1) (+ cnt 1))))
      (helper 0 0))
    (for/sum ([row matrix]) (count-row row)))

  (define (kth-smallest-helper low high)
    (if (= low high)
        low
        (let* ([mid (quotient (+ low high) 2)]
               [count (count-less-equal mid)])
          (if (< count k)
              (kth-smallest-helper (+ mid 1) high)
              (kth-smallest-helper low mid)))))

  (kth-smallest-helper 0 (apply + (map (lambda (row) (last row)) matrix))))