(define (lastStoneWeight stones)
  (define (helper lst)
    (if (null? lst)
        0
        (let* ((sorted (sort lst >))
               (first (car sorted))
               (second (cadr sorted)))
          (if (null? second)
              first
              (let ((new-stone (- first second)))
                (if (= new-stone 0)
                    (helper (cddr sorted))
                    (helper (cons new-stone (cddr sorted)))))))))
  (helper stones))