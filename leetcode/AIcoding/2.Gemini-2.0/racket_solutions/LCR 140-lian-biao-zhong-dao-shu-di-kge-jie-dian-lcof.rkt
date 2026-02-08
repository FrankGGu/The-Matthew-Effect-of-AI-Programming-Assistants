(define (number-of-weeks points energy)
  (let loop ([points points] [energy energy] [weeks 0])
    (cond
      [(empty? points) weeks]
      [(> energy (first points))
       (loop (rest points) (- energy (first points)) (+ weeks 1))]
      [else #f])))