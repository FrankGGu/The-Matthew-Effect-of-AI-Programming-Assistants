(define (find-repeated-dna-sequences s)
  (let* ([n (string-length s)]
         [counts (make-hash)]
         [repeated-sequences (make-set)])
    (when (>= n 10)
      (for ([i (in-range (- n 9))])
        (let ([sub (substring s i (+ i 10))])
          (hash-set! counts sub (+ (hash-ref counts sub 0) 1))
          (when (= (hash-ref counts sub) 2)
            (set-add! repeated-sequences sub)))))
    (set->list repeated-sequences)))