(define (find-buildings heights)
  (let* ((n (length heights))
         (alice-buildings (make-vector n #f))
         (bob-buildings (make-vector n #f))
         (stack '())
         (res '()))

    (for/list ((i (in-range n)))
      (set! alice-buildings (vector-set! alice-buildings i #f))
      (set! bob-buildings (vector-set! bob-buildings i #f)))

    (let loop ((i 0))
      (cond
        ((= i n) #t)
        (else
         (begin
           (while (and (not (empty? stack)) (>= (vector-ref heights (car stack)) (vector-ref heights i)))
             (set! stack (cdr stack)))
           (cond
             ((empty? stack) (set! alice-buildings (vector-set! alice-buildings i #t)))
             (else (set! alice-buildings (vector-set! alice-buildings i #t))))
           (set! stack (cons i stack))
           (loop (+ i 1))))))

    (set! stack '())

    (let loop ((i (- n 1)))
      (cond
        ((< i 0) #t)
        (else
         (begin
           (while (and (not (empty? stack)) (>= (vector-ref heights (car stack)) (vector-ref heights i)))
             (set! stack (cdr stack)))
           (cond
             ((empty? stack) (set! bob-buildings (vector-set! bob-buildings i #t)))
             (else (set! bob-buildings (vector-set! bob-buildings i #t))))
           (set! stack (cons i stack))
           (loop (- i 1))))))

    (for/list ((i (in-range n)))
      (if (and (vector-ref alice-buildings i) (vector-ref bob-buildings i))
          i
          #f))

    (filter number? (for/list ((i (in-range n)))
      (if (and (vector-ref alice-buildings i) (vector-ref bob-buildings i))
          i
          #f)))))