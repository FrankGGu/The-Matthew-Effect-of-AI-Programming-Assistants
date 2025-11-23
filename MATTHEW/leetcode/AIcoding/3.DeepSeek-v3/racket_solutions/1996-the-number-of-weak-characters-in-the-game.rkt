(define (number-of-weak-characters properties)
  (let* ([sorted (sort properties (lambda (a b) (if (= (car a) (car b)) (< (cadr a) (cadr b)) (> (car a) (car b))))]
         [max-def 0]
         [result 0])
    (for ([i (in-range (sub1 (length sorted)) -1 -1)])
      (let ([def (cadr (list-ref sorted i))])
        (if (< def max-def)
            (set! result (add1 result))
            (set! max-def def))))
    result))