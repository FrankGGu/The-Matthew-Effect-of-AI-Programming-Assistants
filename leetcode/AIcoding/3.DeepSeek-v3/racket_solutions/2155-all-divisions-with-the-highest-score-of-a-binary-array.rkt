(define (max-score-indices nums)
  (define n (length nums))
  (define prefix (make-vector (+ n 1) 0))
  (define suffix (make-vector (+ n 1) 0))

  (for ([i (in-range 1 (+ n 1))])
    (vector-set! prefix i (+ (vector-ref prefix (- i 1)) 
                            (if (zero? (list-ref nums (- i 1))) 1 0))))
  )

  (for ([i (in-range (- n 1) -1 -1)])
    (vector-set! suffix i (+ (vector-ref suffix (+ i 1)) 
                            (list-ref nums i)))
  )

  (define max-score 0)
  (define result '())

  (for ([i (in-range 0 (+ n 1))])
    (define current-score (+ (vector-ref prefix i) (vector-ref suffix i)))
    (cond
      [(> current-score max-score)
       (set! max-score current-score)
       (set! result (list i))]
      [(= current-score max-score)
       (set! result (cons i result))]
    )
  )

  (reverse result)
)