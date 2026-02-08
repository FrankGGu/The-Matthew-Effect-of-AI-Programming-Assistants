(define (recover-array nums)
  (let* ([n (length nums)]
         [sorted-nums (sort nums <)]
         [possible-ks (remove-duplicates (filter (lambda (x) (and (positive? x) (zero? (modulo x 2)))) (map (lambda (x) (- x (first sorted-nums))) (drop sorted-nums 1))))])
    (for/or ([k possible-ks])
      (let ([k/2 (/ k 2)]
            [used (make-hash)]
            [result '()])
        (for ([num sorted-nums])
          (unless (hash-ref used num #f)
            (let ([target (+ num k)])
              (if (member target sorted-nums)
                  (begin
                    (hash-set! used num #t)
                    (hash-set! used target #t)
                    (set! result (cons (+ num k/2) result)))
                  )
                  (void)))))
        (if (= (length result) (/ n 2))
            (reverse result)
            #f)))))