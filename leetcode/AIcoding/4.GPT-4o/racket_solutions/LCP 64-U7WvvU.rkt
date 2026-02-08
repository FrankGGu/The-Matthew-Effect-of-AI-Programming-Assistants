#lang racket

(define (minCameraCover root)
  (define (dfs node)
    (if (null? node)
        (list 0 0)
        (let-values ([(left-cams left-need) (dfs (left node))]
                     [(right-cams right-need) (dfs (right node))])
          (define cams (+ left-cams right-cams))
          (define need (+ left-need right-need))
          (if (or (= left-need 0) (= right-need 0))
              (list (+ cams 1) 1)
              (list cams (if (or (= left-need 1) (= right-need 1)) 0 2))))))
  (define-values (total-cams need) (dfs root))
  (if (= need 2) (+ total-cams 1) total-cams))