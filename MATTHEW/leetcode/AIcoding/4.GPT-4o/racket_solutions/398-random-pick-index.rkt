(struct Solution ([nums]))

(define (Solution__init nums)
  (Solution nums))

(define (Solution__pick this target)
  (define indices (for/list ([i (in-range (length (Solution-nums this)))])
                    (when (= (list-ref (Solution-nums this) i) target)
                      i)))
  (random-choice indices))

(define (random-choice lst)
  (if (null? lst)
      (error "Empty list")
      (list-ref lst (random (length lst)))))