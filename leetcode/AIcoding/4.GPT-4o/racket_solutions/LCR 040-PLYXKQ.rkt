(define (maxRectangle matrix)
  (if (null? matrix)
      0
      (let* ([n (length (first matrix))]
             [heights (make-vector n 0)]
             [max-area 0])
        (for ([row matrix])
          (for ([j (in-range n)])
            (if (= (list-ref row j) 1)
                (vector-set! heights j (+ (vector-ref heights j) 1))
                (vector-set! heights j 0)))
          (set! max-area (max max-area (largestRectangleArea heights))))
        max-area)))

(define (largestRectangleArea heights)
  (define (next-smaller-right heights)
    (let ([n (length heights)]
          [stack '()]
          [result (make-vector n n)])
      (for ([i (in-range n)])
        (while (and (not (null? stack))
                    (> (vector-ref heights (car stack)) (vector-ref heights i)))
          (vector-set! result (pop! stack) i))
        (push! stack i))
      (for ([i (in-range (length stack))])
        (vector-set! result (pop! stack) n))
      result))

  (define (next-smaller-left heights)
    (let ([n (length heights)]
          [stack '()]
          [result (make-vector n -1)])
      (for ([i (in-range n)])
        (while (and (not (null? stack))
                    (> (vector-ref heights (car stack)) (vector-ref heights i)))
          (vector-set! result (pop! stack) i))
        (push! stack i))
      (for ([i (in-range (length stack))])
        (vector-set! result (pop! stack) -1))
      result))

  (let* ([n (length heights)]
         [left (next-smaller-left heights)]
         [right (next-smaller-right heights)]
         [max-area 0])
    (for ([i (in-range n)])
      (let ([width (- (vector-ref right i) (vector-ref left i) 1)])
        (set! max-area (max max-area (* width (vector-ref heights i))))))
    max-area))

(define (pop! stack)
  (let ([top (car stack)])
    (set! stack (cdr stack))
    top))

(define (push! stack value)
  (set! stack (cons value stack)))