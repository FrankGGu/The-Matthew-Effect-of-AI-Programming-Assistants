(define/contract (can-cross stones)
  (-> (listof exact-integer?) boolean?)
  (let ([n (length stones)])
    (if (zero? n)
        #t
        (let ([dp (make-hash)])
          (hash-set! dp (cons 0 0) #t)
          (for ([i (in-range n)])
            (for ([entry (in-hash-keys dp)])
              (let* ([pos (car entry)]
                     [k (cdr entry)]
                     [next-pos (+ pos k)]))
                (for ([step (in-list (list (- k 1) k (+ k 1)))])
                  (when (and (> step 0) (member next-pos stones))
                    (hash-set! dp (cons next-pos step) #t)))))
          (ormap (lambda (entry) (= (car entry) (last stones))) (hash-keys dp)))))