(define (make-2d-rectangle-sum matrix)
  (let* ([rows (length matrix)]
         [cols (if (null? matrix) 0 (length (car matrix)))]
         [prefix (make-vector rows)])
    (for ([i (in-range rows)])
      (vector-set! prefix i (make-vector cols 0))
      (vector-set! (vector-ref prefix i) 0 (vector-ref (vector-ref matrix i) 0))
      (for ([j (in-range 1 cols)])
        (vector-set! (vector-ref prefix i) j (+ (vector-ref (vector-ref prefix i) (sub1 j)) (vector-ref (vector-ref matrix i) j)))))
    (for ([i (in-range 1 rows)])
      (for ([j (in-range cols)])
        (vector-set! (vector-ref prefix i) j (+ (vector-ref (vector-ref prefix (sub1 i)) j) (vector-ref (vector-ref prefix i) j)))))
    prefix))

(define (sum-region prefix left-top right-bottom)
  (let* ([top (car left-top)]
         [left (cadr left-top)]
         [bottom (car right-bottom)]
         [right (cadr right-bottom)]
         [total (vector-ref (vector-ref prefix bottom) right)]
         [top-left (if (and (>= top 1) (>= left 1)) (vector-ref (vector-ref prefix (sub1 top)) (sub1 left)) 0)]
         [top-right (if (>= left 1) (vector-ref (vector-ref prefix (sub1 top)) right) 0)]
         [bottom-left (if (>= top 1) (vector-ref (vector-ref prefix bottom) (sub1 left)) 0)])
    (- total top-left top-right bottom-left)))

(define (num-matrix-init matrix)
  (make-2d-rectangle-sum matrix))

(define (num-matrix-sum-region prefix top left bottom right)
  (sum-region prefix (list top left) (list bottom right)))