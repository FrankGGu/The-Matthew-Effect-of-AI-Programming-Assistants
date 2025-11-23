(define (array-nesting nums)
  (let* ((n (length nums))
         (visited (make-vector n #f)))
    (letrec ((solve (i)
              (if (vector-ref visited i)
                  0
                  (let loop ((curr i) (count 0))
                    (if (vector-ref visited curr)
                        count
                        (begin
                          (vector-set! visited curr #t)
                          (loop (vector-ref nums curr) (+ count 1))))))))
      (foldl (lambda (i acc) (max acc (solve i))) 0 (range n)))))