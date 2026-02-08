(define (count-bits n)
  (let loop ([i 0] [acc '()])
    (if (> i n)
        (reverse acc)
        (loop (+ i 1) (cons (integer->list i 2 #:pad-to-length (integer-length n 2) #:reverse? #t) acc)))))

(define (integer->list n base #:pad-to-length [len #f] #:reverse? [reverse? #f])
  (cond
    [(zero? n)
     (if len
         (make-list len 0)
         '(0))]
    [else
     (let loop ([n n] [acc '()])
       (if (zero? n)
           (let ([result (reverse acc)])
             (if len
                 (let ([padding (- len (length result))])
                   (if (> padding 0)
                       (append (make-list padding 0) result)
                       result))
                 result))
           (loop (quotient n base) (cons (remainder n base) acc))))]))

(define (count-bits n)
  (map (lambda (lst) (apply + lst)) (count-bits n)))

(define (count-bits n)
  (let ([ans (make-vector (+ n 1) 0)])
    (for ([i (in-range 1 (+ n 1))])
      (vector-set! ans i (+ (vector-ref ans (quotient i 2)) (remainder i 2))))
    (vector->list ans)))