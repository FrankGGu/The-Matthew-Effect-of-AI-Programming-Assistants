(define (reveal-cards deck)
  (let* ([n (length deck)]
         [sorted-deck (sort deck <)]
         [result-deck '()])
    (for-each (lambda (card)
                (when (not (empty? result-deck))
                  (set! result-deck (append (list (last result-deck)) (drop-right result-deck 1))))
                (set! result-deck (cons card result-deck)))
              (reverse sorted-deck))
    result-deck))