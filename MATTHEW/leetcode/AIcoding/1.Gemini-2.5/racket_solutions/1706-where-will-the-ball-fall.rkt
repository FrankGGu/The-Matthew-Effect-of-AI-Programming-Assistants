(define (where-will-the-ball-fall grid)
  (define num-rows (length grid))
  (define num-cols (length (car grid)))

  (define (simulate-ball r c)
    (cond
      ((= r num-rows)
       c)
      (else
       (define plank (list-ref (list-ref grid r) c))
       (cond
         ((= plank 1) ; Right-leaning plank
          (define next-c (+ c 1))
          (cond
            ((>= next-c num-cols) -1) ; Stuck: out of bounds
            ((= (list-ref (list-ref grid r) next-c) -1) -1) ; Stuck: V-shape
            (else (simulate-ball (+ r 1) next-c))))
         ((= plank -1) ; Left-leaning plank
          (define next-c (- c 1))
          (cond
            ((< next-c 0) -1) ; Stuck: out of bounds
            ((= (list-ref (list-ref grid r) next-c) 1) -1) ; Stuck: V-shape
            (else (simulate-ball (+ r 1) next-c)))))))))

  (for/list ([j (in-range num-cols)])
    (simulate-ball 0 j)))