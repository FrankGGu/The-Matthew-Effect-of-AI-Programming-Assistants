#lang racket

(define/contract (matrix-caller matrix)
  (-> (listof (listof exact-integer?)) (listof (listof exact-integer?)))
  (let ([m (length matrix)]
        [n (length (car matrix))])
    (let ([res (make-list m (make-list n 0))])
      (for-each
       (lambda (query)
         (let ([row1 (car query)]
               [col1 (cadr query)]
               [row2 (caddr query)]
               [col2 (cadddr query)])
           (for ([i (in-range row1 (add1 row2))])
             (for ([j (in-range col1 (add1 col2))])
               (set! res (list-set res i (list-set (list-ref res i) j (+ 1 (list-ref (list-ref res i) j))))))))
       (list (list 0 0 0 0)))
      res)))

(define/contract (range-addition matrix operations)
  (-> (listof (listof exact-integer?)) (listof (listof exact-integer?)) (listof (listof exact-integer?)))
  (let ([m (length matrix)]
        [n (length (car matrix))])
    (let ([res (make-list m (make-list n 0))])
      (for-each
       (lambda (op)
         (let ([row1 (car op)]
               [col1 (cadr op)]
               [row2 (caddr op)]
               [col2 (cadddr op)])
           (for ([i (in-range row1 (add1 row2))])
             (for ([j (in-range col1 (add1 col2))])
               (set! res (list-set res i (list-set (list-ref res i) j (+ 1 (list-ref (list-ref res i) j))))))))
       operations)
      res)))