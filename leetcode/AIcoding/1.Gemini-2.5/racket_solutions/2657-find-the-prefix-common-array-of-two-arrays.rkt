#lang racket
(require racket/vector)
(require racket/set)

(define (find-prefix-common-array A B)
  (let* ([n (vector-length A)])
    (define (loop i current-set-a current-set-b result-list)
      (if (= i n)
          (list->vector (reverse result-list))
          (let* ([val-a (vector-ref A i)]
                 [val-b (vector-ref B i)]
                 [new-set-a (set-add current-set-a val-a)]
                 [new-set-b (set-add current-set-b val-b)]
                 [common-count (set-count (set-intersect new-set-a new-set-b))])
            (loop (+ i 1) new-set-a new-set-b (cons common-count result-list)))))
    (loop 0 (set) (set) '())))