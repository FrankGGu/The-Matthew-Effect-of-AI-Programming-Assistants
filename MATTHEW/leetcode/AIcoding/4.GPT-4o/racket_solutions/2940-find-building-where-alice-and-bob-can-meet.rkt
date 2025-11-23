(define (findBuilding heights)
  (let loop ((n (length heights))
             (left (make-vector n #f))
             (right (make-vector n #f))
             (i 1))
    (if (< i n)
        (begin
          (if (> (vector-ref heights (- i 1)) (vector-ref heights i))
              (vector-set! left i #t))
          (loop n left right (+ i 1)))))

  (let loop2 ((n (length heights))
              (left (make-vector n #f))
              (i 1))
    (if (< i n)
        (begin
          (if (> (vector-ref heights (+ i 1)) (vector-ref heights i))
              (vector-set! right i #t))
          (loop2 n left (+ i 1)))))

  (let loop3 ((n (length heights))
              (i 0)
              (result -1))
    (if (< i n)
        (begin
          (if (and (vector-ref left i) (vector-ref right i))
              (set! result i))
          (loop3 n (+ i 1) result))
        result)))

(define (findBuilding heights)
  (loop heights))