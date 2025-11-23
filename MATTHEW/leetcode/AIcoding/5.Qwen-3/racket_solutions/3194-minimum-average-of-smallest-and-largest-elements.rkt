#lang racket

(define/contract (minimum-average-two-integers-excluded nums)
  (-> (listof exact-integer?) exact-integer?)
  (let ([n (length nums)])
    (if (= n 2)
        (apply + nums)
        (let ([sorted (sort nums <)])
          (let ([avg1 (/ (+ (first sorted) (last sorted)) 2)]
                [avg2 (/ (+ (second sorted) (second-last sorted)) 2)])
            (min avg1 avg2))))))