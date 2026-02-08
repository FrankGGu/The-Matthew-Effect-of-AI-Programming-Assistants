(struct parking-system (
    [big #:mutable]
    [medium #:mutable]
    [small #:mutable]
))

(define (parking-system-init big medium small)
  (parking-system big medium small))

(define (parking-system-add-car ps carType)
  (case carType
    [1 (if (> (parking-system-big ps) 0)
           (begin
             (set-parking-system-big! ps (- (parking-system-big ps) 1))
             #t)
           #f)]
    [2 (if (> (parking-system-medium ps) 0)
           (begin
             (set-parking-system-medium! ps (- (parking-system-medium ps) 1))
             #t)
           #f)]
    [3 (if (> (parking-system-small ps) 0)
           (begin
             (set-parking-system-small! ps (- (parking-system-small ps) 1))
             #t)
           #f)]
    [else #f]))