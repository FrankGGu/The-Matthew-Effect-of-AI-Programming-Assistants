(define (minimum-removal-beans beans)
  (let* ([n (length beans)]
         [sorted-beans (sort beans <)]
         [total-sum (apply + sorted-beans)]
         [min-removed total-sum])

    (for ([i (in-range n)])
      (let* ([k (list-ref sorted-beans i)]
             [remaining-bags-count (- n i)]
             [current-removed (- total-sum (* remaining-bags-count k))])
        (set! min-removed (min min-removed current-removed))))

    min-removed))