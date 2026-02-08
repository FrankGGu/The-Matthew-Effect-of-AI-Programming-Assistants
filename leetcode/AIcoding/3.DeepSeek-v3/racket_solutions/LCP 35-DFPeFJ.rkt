#lang racket

(define/contract (min-cost max-time edges passing-fees)
  (-> exact-integer? (listof (listof exact-integer?)) (listof exact-integer?) exact-integer?)
  (let* ([n (length passing-fees)]
         [graph (make-vector n '())]
         [dist (make-vector n (make-vector (add1 max-time) +inf.0))])
    (for ([edge edges])
      (let ([u (first edge)]
            [v (second edge)]
            [time (third edge)]
            [cost (fourth edge)])
        (vector-set! graph u (cons (list v time cost) (vector-ref graph u)))
        (vector-set! graph v (cons (list u time cost) (vector-ref graph v)))))
    (vector-set! (vector-ref dist 0) 0 (list-ref passing-fees 0))
    (let pq ([heap (make-heap (lambda (a b) (< (third a) (third b))))])
      (heap-add! heap (list 0 0 (list-ref passing-fees 0)))
      (let loop ()
        (if (heap-empty? heap)
            -1
            (let ([curr (heap-remove! heap)])
              (let ([u (first curr)]
                    [t (second curr)]
                    [cost (third curr)])
                (if (= u (sub1 n))
                    cost
                    (begin
                      (for ([neighbor (vector-ref graph u)])
                        (let ([v (first neighbor)]
                              [time (second neighbor)]
                              [edge-cost (third neighbor)])
                          (let ([new-t (+ t time)])
                            (if (and (<= new-t max-time)
                                     (< (+ cost edge-cost (list-ref passing-fees v))
                                        (vector-ref (vector-ref dist v) new-t)))
                                (begin
                                  (vector-set! (vector-ref dist v) new-t
                                               (+ cost edge-cost (list-ref passing-fees v)))
                                  (heap-add! heap (list v new-t (vector-ref (vector-ref dist v) new-t)))))))
                      (loop))))))))))