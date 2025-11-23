#lang racket

(define (kth-smallest-pair nums1 nums2 k)
  (define (count-less-equal x)
    (define (count-in-nums2 val)
      (let loop ([i 0] [cnt 0])
        (if (>= i (length nums2))
            cnt
            (if (<= (* (list-ref nums1 i) (list-ref nums2 i)) x)
                (loop (+ i 1) (+ cnt 1))
                (loop (+ i 1) cnt)))))
    (let loop ([i 0] [cnt 0])
      (if (>= i (length nums1))
          cnt
          (let ([val (list-ref nums1 i)])
            (if (<= val 0)
                (loop (+ i 1) (+ cnt (count-in-nums2 (- x val))))
                (loop (+ i 1) (+ cnt (count-in-nums2 (/ x val))))))))
  (define (binary-search low high)
    (if (> low high)
        low
        (let* ([mid (quotient (+ low high) 2)]
               [cnt (count-less-equal mid)])
          (if (< cnt k)
              (binary-search (+ mid 1) high)
              (binary-search low (- mid 1))))))
  (binary-search (* (car nums1) (car nums2)) (* (last nums1) (last nums2))))