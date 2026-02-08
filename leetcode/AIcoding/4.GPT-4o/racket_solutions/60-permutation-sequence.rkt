(define (get-permutation n k)
  (define (factorial x)
    (if (= x 0) 1 (* x (factorial (- x 1)))))

  (define numbers (map number->string (range 1 (+ n 1))))
  (define result "")
  (set! k (- k 1)) ; convert to zero-indexed

  (let loop ((n n) (k k) (numbers numbers))
    (if (= n 0)
        result
        (let* ((f (factorial (- n 1)))
               (index (quotient k f))
               (next (list-ref numbers index)))
          (set! result (string-append result next))
          (set! numbers (remove (lambda (x) (equal? x next)) numbers))
          (loop (- n 1) (modulo k f) numbers)))))