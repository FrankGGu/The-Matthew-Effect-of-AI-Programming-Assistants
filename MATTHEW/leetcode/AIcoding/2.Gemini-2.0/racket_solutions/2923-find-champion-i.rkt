(define (findChampion n defeats)
  (let ([defeated-count (make-vector n 0)])
    (for ([defeat defeats])
      (vector-set! defeated-count (cadr defeat) (+ 1 (vector-ref defeated-count (cadr defeat)))))
    (let loop ([i 0])
      (cond
        [(= i n) -1]
        [(= (vector-ref defeated-count i) 0) i]
        [else (loop (+ i 1))]))))