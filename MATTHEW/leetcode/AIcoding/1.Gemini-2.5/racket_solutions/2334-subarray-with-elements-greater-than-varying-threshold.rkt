(define (valid-subarray-size nums threshold)
  (define n (vector-length nums))

  ;; Calculate left boundaries (index of previous smaller element)
  (define left (make-vector n))
  (define stack '()) ; stack stores indices
  (for ([i (in-range n)])
    (let loop ()
      (when (and (not (empty? stack))
                 (>= (vector-ref nums (car stack)) (vector-ref nums i)))
        (set! stack (cdr stack))
        (loop)))
    (vector-set! left i (if (empty? stack) -1 (car stack)))
    (set! stack (cons i stack)))

  ;; Calculate right boundaries (index of next smaller element)
  (define right (make-vector n))
  (set! stack '()) ; reset stack
  (for ([i (in-range (- n 1) -1 -1)]) ; Iterate from n-1 down to 0
    (let loop ()
      (when (and (not (empty? stack))
                 (>= (vector-ref nums (car stack)) (vector-ref nums i)))
        (set! stack (cdr stack))
        (loop)))
    (vector-set! right i (if (empty? stack) n (car stack)))
    (set! stack (cons i stack)))

  ;; Check condition
  (let loop ([i 0])
    (cond
      [(= i n) #f] ; No such subarray found
      [(> (* (vector-ref nums i)
             (- (vector-ref right i) (vector-ref left i) 1))
          threshold)
       #t]
      [else (loop (+ i 1))])))