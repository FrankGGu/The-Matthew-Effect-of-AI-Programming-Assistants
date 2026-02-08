(define (min-number-of-edges (n : Integer) (edges : (Listof (Listof Integer))))
  (define adj (make-vector (add1 n) '()))
  (for-each (lambda (edge)
              (let ((u (first edge)) (v (second edge)))
                (vector-set! adj u (cons v (vector-ref adj u)))
                (vector-set! adj v (cons u (vector-ref adj v)))))
            edges)
  (define odd-nodes (filter (lambda (i) (odd? (length (vector-ref adj i)))) (range 1 (add1 n))))
  (if (zero? (length odd-nodes))
      0
      (if (odd? (length odd-nodes))
          -1
          (let ((s (set->list (list->set odd-nodes))))
            (if (= 2 (length s))
                (if (not (member? (first s) (vector-ref adj (second s))))
                    1
                    2)
                (if (= 4 (length s))
                    (let ((a (first s)) (b (second s)) (c (third s)) (d (fourth s)))
                      (cond
                        [(not (member? a (vector-ref adj b))) 1]
                        [(not (member? a (vector-ref adj c))) 1]
                        [(not (member? a (vector-ref adj d))) 1]
                        [(not (member? b (vector-ref adj c))) 1]
                        [(not (member? b (vector-ref adj d))) 1]
                        [(not (member? c (vector-ref adj d))) 1]
                        [(and (not (member? a (vector-ref adj c))) (not (member? b (vector-ref adj d)))) 2]
                        [(and (not (member? a (vector-ref adj d))) (not (member? b (vector-ref adj c)))) 2]
                        :else 2))
                    )
                (if (= 6 (length s))
                    3
                    2))))))