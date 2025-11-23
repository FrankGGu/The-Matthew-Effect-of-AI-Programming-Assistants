(define (combination-sum candidates target)
  (let ([results '()]
        [sorted-candidates (sort candidates <)])

    (define (backtrack remaining-target current-combination start-index)
      (cond
        ((= remaining-target 0)
         (set! results (cons (reverse current-combination) results)))
        ((< remaining-target 0)
         '())
        (else
         (for ([i (in-range start-index (length sorted-candidates))])
           (let ([candidate (list-ref sorted-candidates i)])
             (when (<= candidate remaining-target)
               (backtrack (- remaining-target candidate) (cons candidate current-combination) i)))))))

    (backtrack target '() 0)
    (reverse results)))