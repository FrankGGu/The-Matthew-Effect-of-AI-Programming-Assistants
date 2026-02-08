#lang racket

(require data/heap)

(define/contract (minimum-time grid)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (if (and (equal? (caar grid) 0) (equal? (cadar grid) 1))
      -1
      (let* ([m (length grid)]
             [n (length (car grid))]
             [dirs '((0 1) (1 0) (0 -1) (-1 0))]
             [visited (make-hash)]
             [heap (make-heap (lambda (a b) (<= (car a) (car b))))])
        (hash-set! visited '(0 0) 0)
        (heap-add! heap '(0 0 0))
        (let loop ()
          (if (heap-empty? heap)
              -1
              (let* ([current (heap-min heap)]
                     [t (car current)]
                     [i (cadr current)]
                     [j (caddr current)]
                     [_ (heap-remove! heap)])
                (if (and (= i (- m 1)) (= j (- n 1)))
                    t
                    (begin
                      (for ([dir dirs])
                        (let* ([ni (+ i (car dir))]
                               [nj (+ j (cadr dir))])
                          (when (and (>= ni 0) (< ni m) (>= nj 0) (< nj n))
                            (let* ([required-time (list-ref (list-ref grid ni) nj)]
                                   [new-time (max (+ t 1) required-time)]
                                   [prev-time (hash-ref visited (list ni nj) +inf.0)])
                              (when (< new-time prev-time)
                                (hash-set! visited (list ni nj) new-time)
                                (heap-add! heap (list new-time ni nj)))))))
                      (loop)))))))))