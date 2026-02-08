(define (num-pairs-target words target)
  (define len (length words))
  (define count 0)
  (for* ([i (in-range len)]
         [j (in-range len)])
    (when (and (not (= i j)) (string=? (string-append (list-ref words i) (list-ref words j)) target))
      (set! count (+ count 1))))
  count)