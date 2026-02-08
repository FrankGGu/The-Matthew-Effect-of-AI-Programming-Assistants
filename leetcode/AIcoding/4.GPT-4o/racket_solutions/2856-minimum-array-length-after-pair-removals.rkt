(define (minArrayLength nums)
  (define (helper nums)
    (if (null? nums) 0
        (let ((count (length nums)))
          (if (= count 1) 1
              (let ((sorted (sort nums <)))
                (let loop ((lst sorted) (res 0))
                  (cond
                    ((null? (cdr lst)) (+ res 1))
                    ((= (car lst) (cadr lst)) (loop (cddr lst) res))
                    (else (loop (cdr lst) (+ res 1))))))))))
  (helper nums))

(minArrayLength '(1 2 3 4))