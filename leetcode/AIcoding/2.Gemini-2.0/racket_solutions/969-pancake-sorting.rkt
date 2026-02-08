(define (flip arr k)
  (let loop ((i 0) (j (- k 1)))
    (if (> i j)
        arr
        (begin
          (let ((temp (list-ref arr i)))
            (vector-set! arr i (list-ref arr j))
            (vector-set! arr j temp))
          (loop (+ i 1) (- j 1))))))

(define (find-max arr n)
  (let loop ((i 0) (max-index 0) (max-val (list-ref arr 0)))
    (if (= i n)
        max-index
        (if (> (list-ref arr i) max-val)
            (loop (+ i 1) i (list-ref arr i))
            (loop (+ i 1) max-index max-val)))))

(define (pancake-sort arr)
  (let ((n (length arr))
        (result '()))
    (let loop ((curr-size n))
      (if (= curr-size 1)
          (reverse result)
          (let ((max-index (find-max arr curr-size)))
            (if (= max-index (- curr-size 1))
                (loop (- curr-size 1))
                (begin
                  (if (not (= max-index 0))
                      (begin
                        (flip arr (+ max-index 1))
                        (set! result (cons (+ max-index 1) result))))
                  (flip arr curr-size)
                  (set! result (cons curr-size result))
                  (loop (- curr-size 1)))))))))