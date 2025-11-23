(define (rotate-matrix matrix)
  (let* ([n (length matrix)]
         [new-matrix (make-list n (make-list n 0))])
    (for ([i (in-range n)])
      (for ([j (in-range n)])
        (list-set! (list-ref new-matrix j) (- n 1 i) (list-ref (list-ref matrix i) j))))
    new-matrix))

(define (equal-matrix? a b)
  (and (= (length a) (length b))
       (andmap (lambda (row-a row-b)
                 (and (= (length row-a) (length row-b))
                      (andmap = row-a row-b)))
               a b)))

(define (find-rotation matrix target)
  (define n (length matrix))
  (define (rotate-and-check m)
    (equal-matrix? m target))
  (let loop ([m matrix] [count 0])
    (if (>= count 4)
        #f
        (if (rotate-and-check m)
            #t
            (loop (rotate-matrix m) (+ count 1))))))