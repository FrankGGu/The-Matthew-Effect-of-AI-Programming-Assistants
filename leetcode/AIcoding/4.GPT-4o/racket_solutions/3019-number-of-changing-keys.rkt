(define (numChangingKeys keys) 
  (define (count-changes keys)
    (if (null? keys)
        0
        (let loop ((current (car keys)) (rest (cdr keys)) (count 0))
          (if (null? rest)
              count
              (if (not (= current (car rest)))
                  (loop (car rest) (cdr rest) (+ count 1))
                  (loop current (cdr rest) count)))))
  (count-changes keys))

(define (numberOfChangingKeys keys)
  (numChangingKeys keys))