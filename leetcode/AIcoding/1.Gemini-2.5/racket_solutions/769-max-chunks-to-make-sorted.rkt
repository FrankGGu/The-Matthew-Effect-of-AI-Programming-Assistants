(define (max-chunks-to-make-sorted arr)
  (let* ([n (length arr)])
    (let loop ([i 0]
               [max-val-in-prefix -1]
               [chunks 0])
      (if (= i n)
          chunks
          (let* ([current-element (list-ref arr i)]
                 [new-max-val-in-prefix (max max-val-in-prefix current-element)])
            (if (= new-max-val-in-prefix i)
                (loop (+ i 1) new-max-val-in-prefix (+ chunks 1))
                (loop (+ i 1) new-max-val-in-prefix chunks)))))))