(define (relocate-marbles nums moveFrom moveTo)
  (define num-set (set))
  (for ([num nums])
    (set! num-set (set-add num-set num)))

  (for ([from moveFrom] [to moveTo])
    (when (set-member? num-set from)
      (set! num-set (set-remove num-set from))
      (set! num-set (set-add num-set to))))

  (sort (set->list num-set) <))