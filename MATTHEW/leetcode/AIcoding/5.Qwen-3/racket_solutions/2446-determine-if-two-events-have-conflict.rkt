(define (have-conflict event1 event2)
  (let ([start1 (car event1)]
        [end1 (cadr event1)]
        [start2 (car event2)]
        [end2 (cadr event2)])
    (and (<= start1 end2) (<= start2 end1))))