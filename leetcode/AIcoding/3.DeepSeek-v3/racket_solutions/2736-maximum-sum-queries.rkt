#lang racket

(require data/order)
(require data/heap)

(define (maximum-sum-queries nums1 nums2 queries)
  (define n (length nums1))
  (define m (length queries))
  (define nums (sort (for/list ([x nums1] [y nums2]) (cons x y)) 
                (lambda (a b) (or (> (car a) (car b)) (and (= (car a) (car b)) (> (cdr a) (cdr b))))))
  (define qs (sort (for/list ([q queries] [i (in-naturals)]) (cons (car q) (cons (cdr q) i))) 
                (lambda (a b) (> (car a) (car b)))))
  (define result (make-vector m -1))
  (define heap (make-heap (lambda (a b) (>= (cdr a) (cdr b)))))

  (let loop ([i 0] [j 0])
    (when (or (< i n) (< j m))
      (if (or (>= j m) (and (< i n) (>= (car (list-ref nums i)) (car (list-ref qs j)))))
          (let ([x (car (list-ref nums i))] [y (cdr (list-ref nums i))] [sum (+ (car (list-ref nums i)) (cdr (list-ref nums i)))])
            (heap-add! heap (cons y sum))
            (loop (add1 i) j))
          (let* ([q (list-ref qs j)]
                 [xq (car q)]
                 [yq (car (cdr q))]
                 [idx (cdr (cdr q))])
            (let find-max ()
              (if (heap-empty? heap)
                  (void)
                  (let ([top (heap-min heap)])
                    (if (>= (car top) yq)
                        (vector-set! result idx (max (vector-ref result idx) (cdr top)))
                        (begin
                          (heap-remove-min! heap)
                          (find-max))))))
            (loop i (add1 j))))))
  (vector->list result))