(define (exist board word)
  (define (backtrack i j k)
    (if (= k (string-length word))
        #t
        (if (or (< i 0) (>= i (length board)) (< j 0) (>= (length (list-ref board i)) (string-length word)))
            #f
            (if (char=? (string-ref word k) (list-ref (list-ref board i) j))
                (begin
                  (set! (list-ref (list-ref board i) j) #\#)
                  (define res (or (backtrack (+ i 1) j (+ k 1))
                                  (backtrack (- i 1) j (+ k 1))
                                  (backtrack i (+ j 1) (+ k 1))
                                  (backtrack i (- j 1) (+ k 1))))
                  (set! (list-ref (list-ref board i) j) (string-ref word k))
                  res)
                #f))))

  (for ([i (in-range (length board))])
    (for ([j (in-range (length (list-ref board i)))])
      (when (backtrack i j 0)
        (return #t))))
  #f)