#lang racket

(require data/heap)
(require racket/hash)

(define (kth-smallest-sum mat k)
  (define m (length mat))
  (define n (length (car mat)))

  (define heap (make-heap (lambda (a b) (< (car a) (car b)))))
  (define visited (make-hash equal?))

  (define initial-sum (apply + (map car mat)))
  (define initial-indices (build-list m (lambda (i) 0)))

  (heap-add! heap (cons initial-sum initial-indices))
  (hash-set! visited initial-indices #t)

  (define result-sum 0)
  (for ([i (in-range k)])
    (define current-state (heap-min heap))
    (heap-remove-min! heap)

    (set! result-sum (car current-state))
    (define current-indices (cdr current-state))

    (for ([j (in-range m)])
      (define current-idx-j (list-ref current-indices j))
      (when (< (add1 current-idx-j) n)
        (define next-indices (list-set current-indices j (add1 current-idx-j)))
        (unless (hash-has-key? visited next-indices)
          (define old-val (list-ref (list-ref mat j) current-idx-j))
          (define new-val (list-ref (list-ref mat j) (add1 current-idx-j)))
          (define next-sum (+ result-sum (- old-val) new-val))
          (heap-add! heap (cons next-sum next-indices))
          (hash-set! visited next-indices #t)))))

  result-sum)