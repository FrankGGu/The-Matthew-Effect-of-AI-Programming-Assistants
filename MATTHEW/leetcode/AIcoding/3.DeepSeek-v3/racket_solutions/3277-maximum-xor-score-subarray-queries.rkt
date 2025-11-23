(define (maximum-xor-subarray nums queries)
  (define (xor-up-to n)
    (foldl bitwise-xor 0 (take nums n)))
  (let loop ([queries queries] [result '()])
    (if (null? queries)
        (reverse result)
        (let* ([query (car queries)]
               [l (car query)]
               [r (cadr query)]
               [max-xor 0])
          (for ([i (in-range l (add1 r))])
            (for ([j (in-range i (add1 r))])
              (let ([current (foldl bitwise-xor 0 (take (drop nums i) (- (add1 j) i)))])
                (when (> current max-xor)
                  (set! max-xor current)))))
          (loop (cdr queries) (cons max-xor result))))))