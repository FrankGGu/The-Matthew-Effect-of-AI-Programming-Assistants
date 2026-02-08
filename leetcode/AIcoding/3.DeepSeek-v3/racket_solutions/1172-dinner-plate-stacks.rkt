(define dinner-plates%
  (class object%
    (super-new)
    (init-field [capacity 0])
    (define stacks (make-hash))
    (define left 0)
    (define right -1)

    (define/public (push val)
      (let loop ([index left])
        (cond
          [(> index right) 
           (hash-set! stacks (add1 right) (make-vector capacity 0))
           (set! right (add1 right))
           (vector-set! (hash-ref stacks right) 0 val)
           (hash-set! stacks right (vector-copy (hash-ref stacks right) 0 1))]
          [else
           (define current-stack (hash-ref stacks index))
           (if (< (vector-length current-stack) capacity)
               (begin
                 (hash-set! stacks index (vector-append current-stack (vector val)))
                 (when (= index left)
                   (let loop ([i left])
                     (when (and (<= i right) 
                                (= (vector-length (hash-ref stacks i)) capacity))
                       (set! left (add1 i))
                       (loop (add1 i))))))
               (loop (add1 index)))])))

    (define/public (pop)
      (let loop ([index right])
        (cond
          [(< index left) -1]
          [else
           (define current-stack (hash-ref stacks index))
           (if (> (vector-length current-stack) 0)
               (let ([val (vector-ref current-stack (sub1 (vector-length current-stack)))])
                 (hash-set! stacks index (vector-copy current-stack 0 (sub1 (vector-length current-stack))))
                 (when (= index right)
                   (let loop ([i right])
                     (when (and (>= i left) 
                                (= (vector-length (hash-ref stacks i)) 0))
                       (set! right (sub1 i))
                       (loop (sub1 i)))))
                 val)
               (loop (sub1 index)))])))

    (define/public (pop-at-stack index)
      (if (or (< index left) (> index right) (not (hash-has-key? stacks index)))
          -1
          (let ([current-stack (hash-ref stacks index)])
            (if (= (vector-length current-stack) 0)
                -1
                (let ([val (vector-ref current-stack (sub1 (vector-length current-stack)))])
                  (hash-set! stacks index (vector-copy current-stack 0 (sub1 (vector-length current-stack))))
                  (when (and (= index left) (= (vector-length (hash-ref stacks index)) 0))
                    (set! left (add1 left)))
                  val)))))))

(define (make-dinner-plates capacity)
  (new dinner-plates% [capacity capacity]))