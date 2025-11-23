(define (lowest-common-ancestor root p q)
  (cond
    [(and (< (val p) (val root)) (< (val q) (val root)))
     (lowest-common-ancestor (left root) p q)]
    [(and (> (val p) (val root)) (> (val q) (val root)))
     (lowest-common-ancestor (right root) p q)]
    [else
     root]))