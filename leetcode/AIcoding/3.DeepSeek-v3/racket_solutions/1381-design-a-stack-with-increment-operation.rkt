(define-struct stack (vec top))

(define (make-stack max-size)
  (make-stack (make-vector max-size 0) -1))

(define (push stack val)
  (if (< (stack-top stack) (sub1 (vector-length (stack-vec stack))))
      (struct-copy stack stack
                   [vec (vector-copy (stack-vec stack))]
                   [top (add1 (stack-top stack))]
                   [vec (vector-set! (stack-vec stack) (add1 (stack-top stack)) val)]))
      stack))

(define (pop stack)
  (if (>= (stack-top stack) 0)
      (let ([val (vector-ref (stack-vec stack) (stack-top stack))])
        (struct-copy stack stack
                     [vec (vector-copy (stack-vec stack))]
                     [top (sub1 (stack-top stack))])
        val)
      -1))

(define (increment stack k val)
  (let ([n (min k (add1 (stack-top stack)))])
    (struct-copy stack stack
                 [vec (vector-copy (stack-vec stack))]
                 [vec (for ([i (in-range n)])
                        (vector-set! (stack-vec stack) i 
                                     (+ (vector-ref (stack-vec stack) i) val)))])))