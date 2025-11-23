(define (beautiful-splits nums)
  (let* ([n (length nums)]
         [prefix (make-vector n 0)]
         [suffix (make-vector n 0)]
         [unique-prefix (make-hash)]
         [unique-suffix (make-hash)]
         [res 0])
    (hash-set! unique-prefix (list-ref nums 0) #t)
    (vector-set! prefix 0 1)
    (for ([i (in-range 1 n)])
      (hash-set! unique-prefix (list-ref nums i) #t)
      (vector-set! prefix i (hash-count unique-prefix)))

    (hash-set! unique-suffix (list-ref nums (- n 1)) #t)
    (vector-set! suffix (- n 1) 1)
    (for ([i (in-range (- n 2) -1 -1)])
      (hash-set! unique-suffix (list-ref nums i) #t)
      (vector-set! suffix i (hash-count unique-suffix)))

    (for ([i (in-range 0 (- n 1))])
      (when (= (vector-ref prefix i) (vector-ref suffix (+ i 1)))
        (set! res (+ res 1))))
    res))