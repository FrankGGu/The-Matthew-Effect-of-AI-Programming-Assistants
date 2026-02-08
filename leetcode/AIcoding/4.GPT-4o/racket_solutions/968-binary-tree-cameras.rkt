#lang racket

(define (minCameraCover root)
  (define (dfs node)
    (if (not node)
        (values 0 1)
        (let-values ([(left-cams left-state) (dfs (left node))]
                     [(right-cams right-state) (dfs (right node))])
          (cond
            [(= left-state 0) (values (+ left-cams right-cams 1) 2)]
            [(= right-state 0) (values (+ left-cams right-cams 1) 2)]
            [else (values (+ left-cams right-cams) 0)]))))

  (define-values (cameras state) (dfs root))
  (if (= state 0) 
      (+ cameras 1) 
      cameras))

(define (left node) (if node (node 'left)))
(define (right node) (if node (node 'right)))