(define (add-rungs rungs dist)
  (let loop ([rungs rungs] [prev 0] [count 0])
    (cond
      [(empty? rungs) count]
      [else
       (let ([curr (car rungs)])
         (if (> (- curr prev) dist)
             (loop (cdr rungs) curr (+ count (quotient (- curr prev -1) dist)))
             (loop (cdr rungs) curr count)))])))