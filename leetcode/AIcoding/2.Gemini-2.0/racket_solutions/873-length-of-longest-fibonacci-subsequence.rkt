(define (len-longest-fib-subseq a)
  (let* ([n (length a)]
         [s (make-hash)]
         [ans 0])
    (for/list ([i (in-range n)])
      (hash-set! s (list-ref a i) i))
    (for ([i (in-range n)])
      (for ([j (in-range (+ i 1) n)])
        (let loop ([a (list-ref a i)]
                   [b (list-ref a j)]
                   [len 2])
          (let ([c (+ a b)])
            (cond
              [(hash-has-key? s c)
               (loop b c (+ len 1))]
              [else
               (set! ans (max ans len))])))))
    (if (> ans 2) ans 0)))