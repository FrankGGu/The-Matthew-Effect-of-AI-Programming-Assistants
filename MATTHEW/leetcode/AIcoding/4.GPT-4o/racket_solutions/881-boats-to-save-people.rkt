(define (numRescueBoats people limit)
  (define sorted-people (sort people <))
  (define (helper left right boats)
    (if (> left right)
        boats
        (if (<= (+ (list-ref sorted-people left) (list-ref sorted-people right)) limit)
            (helper (+ left 1) (- right 1) (+ boats 1))
            (helper left (- right 1) (+ boats 1)))))
  (helper 0 (- (length sorted-people) 1) 0))

(define (numRescueBoats people limit)
  (numRescueBoats people limit))