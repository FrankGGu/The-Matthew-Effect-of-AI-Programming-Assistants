(define (zero-array-transformation arr)
  (let loop ([arr arr] [count 0])
    (if (equal? arr (make-list (length arr) 0))
        count
        (let* ([n (length arr)]
               [new-arr (make-list n 0)]
               [changed? #f])
          (for ([i (in-range n)])
            (cond
              [(zero? (list-ref arr i))
               (list-set! new-arr i 0)]
              [(and (> i 0) (zero? (list-ref arr (- i 1))))
               (list-set! new-arr i 0)
               (set! changed? #t)]
              [(and (< i (- n 1)) (zero? (list-ref arr (+ i 1))))
               (list-set! new-arr i 0)
               (set! changed? #t)]
              [else
               (list-set! new-arr i 1)]))
          (if (not changed?)
              -1
              (loop new-arr (+ count 1)))))))