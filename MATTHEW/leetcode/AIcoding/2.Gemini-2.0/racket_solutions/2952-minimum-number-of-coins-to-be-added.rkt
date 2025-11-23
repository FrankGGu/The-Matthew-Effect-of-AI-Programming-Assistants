(define (minimum-added-coins coins target)
  (define sorted-coins (sort coins <))
  (define (helper current-target index count)
    (cond
      [(>= current-target 0) count]
      [(< index 0) (+ count 1)]
      [(>= current-target (list-ref sorted-coins index))
       (helper (- current-target (list-ref sorted-coins index)) index count)]
      [else (helper (+ current-target current-target 1) (sub1 index) (+ count 1))]))
  (helper target (sub1 (length sorted-coins)) 0))