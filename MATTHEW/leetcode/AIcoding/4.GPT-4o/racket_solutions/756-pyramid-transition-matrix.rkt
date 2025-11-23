(define (pyramidTransition bottom allowed)
  (define allowed-set (foldl (lambda (x acc) (hash-set acc (string->symbol x))) (make-hash) allowed))

  (define (can-build current)
    (if (= (length current) 1)
        #t
        (for/or ([i (in-range (- (length current) 1))])
          (let ([up (list (string-append (list-ref current i) (list-ref current (+ i 1))))])
            (for/or ([s (hash-ref allowed-set up '())])
              (can-build (cons s (remove-first! current i))))))))

  (can-build bottom))

(define (remove-first! lst index)
  (if (null? lst)
      '()
      (if (= index 0)
          (cdr lst)
          (cons (car lst) (remove-first! (cdr lst) (- index 1))))))

(define (pyramidTransitionMatrix bottom allowed)
  (pyramidTransition bottom allowed))