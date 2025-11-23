(define (maximumDifference nums)
  (define (freqs lst)
    (foldl (lambda (x acc) 
              (if (even? x) 
                  (update acc 'even (lambda (v) (+ v 1)) 1)
                  (update acc 'odd (lambda (v) (+ v 1)) 1))) 
            (hash 'even 0 'odd 0) lst))

  (define frequencies (freqs nums))
  (define even-count (hash-ref frequencies 'even))
  (define odd-count (hash-ref frequencies 'odd))

  (if (or (zero? even-count) (zero? odd-count))
      0
      (abs (- even-count odd-count))))