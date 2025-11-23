(define (number-of-weak-characters properties)
  (define sorted-properties (sort properties > #:key car))
  (define (helper sorted-properties max-defense count)
    (cond
      [(empty? sorted-properties) count]
      [else
       (let* ([current-attack (caar sorted-properties)]
              [current-defense (cadar sorted-properties)]
              [rest (cdr sorted-properties)])
         (if (< current-defense max-defense)
             (helper rest max-defense (+ count 1))
             (helper rest (max max-defense current-defense) count)))]))
  (helper sorted-properties -inf.0 0))