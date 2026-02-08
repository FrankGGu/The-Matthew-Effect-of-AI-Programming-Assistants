#lang racket

(define/contract (max-building n restrictions)
  (-> exact-integer? (listof (listof exact-integer?)) exact-integer?)
  (let* ([sorted-res (sort (cons (list 1 0) restrictions) (lambda (a b) (< (car a) (car b))))]
         [m (length sorted-res)]
         [res (make-vector m 0)])
    (vector-set! res 0 0)
    (for ([i (in-range 1 m)])
      (let ([prev-id (car (list-ref sorted-res (sub1 i)))]
            [prev-h (cadr (list-ref sorted-res (sub1 i)))]
        (let ([curr-id (car (list-ref sorted-res i))]
              [curr-h (cadr (list-ref sorted-res i))])
          (vector-set! res i (min curr-h (+ prev-h (- curr-id prev-id)))))))
    (for ([i (in-range (- m 2) -1 -1)])
      (let ([next-id (car (list-ref sorted-res (add1 i)))]
            [next-h (cadr (list-ref sorted-res (add1 i)))]
            [curr-id (car (list-ref sorted-res i))]
            [curr-h (vector-ref res i)])
        (vector-set! res i (min curr-h (+ next-h (- next-id curr-id))))))
    (let loop ([i 0]
               [max-h 0])
      (if (>= i (sub1 m))
          (max max-h (+ (vector-ref res i) (- n (car (list-ref sorted-res i)))))
          (let* ([left-id (car (list-ref sorted-res i))]
                 [left-h (vector-ref res i)]
                 [right-id (car (list-ref sorted-res (add1 i)))]
                 [right-h (vector-ref res (add1 i)))]
                 [diff-id (- right-id left-id)]
                 [diff-h (abs (- right-h left-h))])
            (loop (add1 i) (max max-h (+ (max left-h right-h) (quotient (+ diff-id (- diff-h)) 2)))))))))