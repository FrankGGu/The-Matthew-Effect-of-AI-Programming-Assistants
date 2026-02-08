(define (maximum-rooks-value-sum matrix rooks)
  (define (get-max-sum matrix rooks visited)
    (cond
      [(empty? rooks) 0]
      [else
       (let* ([current-rook (car rooks)]
              [row (car current-rook)]
              [col (cadr current-rook)]
              [remaining-rooks (cdr rooks)]
              [new-matrix (make-matrix (length matrix) (length (car matrix)) 0)]
              [new-visited (make-vector (length matrix) #f)])
         (for ([i (in-range (length matrix))])
           (for ([j (in-range (length (car matrix)))])
             (cond
               [(= i row) (vector-set! (vector-ref new-matrix i) j 0)]
               [(= j col) (vector-set! (vector-ref new-matrix i) j 0)]
               [else (vector-set! (vector-ref new-matrix i) j (vector-ref (vector-ref matrix i) j))])))
         (for ([i (in-range (length visited))])
           (vector-set! new-visited i #f))

         (let ([max-sum (get-max-sum new-matrix remaining-rooks new-visited)])
           (+ (vector-ref (vector-ref matrix row) col) max-sum)))])))

  (get-max-sum matrix rooks (make-vector (length matrix) #f)))