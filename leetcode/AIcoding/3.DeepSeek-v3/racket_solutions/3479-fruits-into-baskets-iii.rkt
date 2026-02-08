(define/contract (total-fruit fruits)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([left 0] [right 0] [max-count 0] [counts (make-hash)] [types 0])
    (cond
      [(>= right (length fruits)) max-count]
      [else
       (define fruit (list-ref fruits right))
       (hash-update! counts fruit (lambda (v) (add1 v)) 0)
       (when (= (hash-ref counts fruit) 1)
         (set! types (add1 types)))
       (let loop2 ([left left] [types types] [counts counts])
         (cond
           [(> types 2)
            (define left-fruit (list-ref fruits left))
            (hash-update! counts left-fruit sub1)
            (when (= (hash-ref counts left-fruit) 0)
              (set! types (sub1 types)))
            (loop2 (add1 left) types counts)]
           [else
            (loop (add1 left) (add1 right) (max max-count (- right left -1)) counts types)]))])))