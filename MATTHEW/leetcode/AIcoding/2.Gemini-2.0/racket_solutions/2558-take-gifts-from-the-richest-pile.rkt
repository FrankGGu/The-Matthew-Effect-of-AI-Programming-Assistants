(define (take-gifts gifts k)
  (for ([i (in-range k)])
    (define max-index (argmax gifts))
    (set! gifts (list-set gifts max-index (inexact->exact (floor (sqrt (list-ref gifts max-index)))))))
  (apply + gifts))

(define (argmax lst)
  (let loop ([lst lst] [max-val (car lst)] [max-index 0] [index 0])
    (cond
      [(empty? lst) max-index]
      [(> (car lst) max-val) (loop (cdr lst) (car lst) index (+ 1 index))]
      [else (loop (cdr lst) max-val max-index (+ 1 index))])))