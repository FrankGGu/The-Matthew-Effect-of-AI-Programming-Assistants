(define (numColorfulLights lights)
  (define (helper lst)
    (cond
      ((null? lst) 0)
      (else (+ 1 (helper (cdr lst))))))
  (helper lights))

(define (numColorfulLights lights)
  (let loop ((i 0) (count 0))
    (if (< i (length lights))
        (loop (+ i 1) (+ count (if (= (list-ref lights i) 1) 1 0)))
        count)))

(numColorfulLights '(1 0 1 1 0 1))