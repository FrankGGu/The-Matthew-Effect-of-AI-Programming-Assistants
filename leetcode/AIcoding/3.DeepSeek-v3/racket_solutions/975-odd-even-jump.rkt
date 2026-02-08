(define/contract (odd-even-jumps arr)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([n (length arr)]
         [sorted-indexes (sort (range n) (lambda (i j) (or (< (list-ref arr i) (list-ref arr j))
                                                          (and (= (list-ref arr i) (list-ref arr j)) (< i j)))))]
         [next-higher (make-vector n -1)]
         [stack '()])
    (for ([i sorted-indexes])
      (while (and (not (null? stack)) (< (car stack) i))
        (vector-set! next-higher (car stack) i)
        (set! stack (cdr stack)))
      (set! stack (cons i stack)))

    (set! sorted-indexes (sort (range n) (lambda (i j) (or (> (list-ref arr i) (list-ref arr j))
                                                          (and (= (list-ref arr i) (list-ref arr j)) (< i j))))))
    (let ([next-lower (make-vector n -1)]
          [stack '()])
      (for ([i sorted-indexes])
        (while (and (not (null? stack)) (< (car stack) i))
          (vector-set! next-lower (car stack) i)
          (set! stack (cdr stack)))
        (set! stack (cons i stack)))

    (let ([odd (make-vector n #f)]
          [even (make-vector n #f)])
      (vector-set! odd (- n 1) #t)
      (vector-set! even (- n 1) #t)
      (for ([i (in-range (- n 2) -1 -1)])
        (when (>= (vector-ref next-higher i) 0)
          (vector-set! odd i (vector-ref even (vector-ref next-higher i))))
        (when (>= (vector-ref next-lower i) 0)
          (vector-set! even i (vector-ref odd (vector-ref next-lower i)))))
      (count identity (vector->list odd)))))