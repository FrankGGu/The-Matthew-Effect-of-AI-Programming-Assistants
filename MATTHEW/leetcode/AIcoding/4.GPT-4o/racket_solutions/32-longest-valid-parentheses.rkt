(define (longestValidParentheses s)
  (define n (string-length s))
  (define dp (make-vector n 0))
  (define max-length 0)

  (for ([i (in-range 1 n)])
    (cond
      [(and (= (string-ref s i) #\)) 
            (= (string-ref s (- i 1)) #\() )
       (vector-set! dp i (+ 2 (if (>= (- i 2) 0) (vector-ref dp (- i 2)) 0)))
       (set! max-length (max max-length (vector-ref dp i)))
      ]
      [(and (= (string-ref s i) #\)) 
            (= (string-ref s (- i 1)) #\)) 
            (when (>= (- i 1) 1)
              (when (= (string-ref s (- i 2)) #\()
                (vector-set! dp i (+ 2 (if (>= (- i 3) 0) (vector-ref dp (- i 3)) 0))))
                (set! max-length (max max-length (vector-ref dp i))))))
      ]
    )
  )

  max-length
)