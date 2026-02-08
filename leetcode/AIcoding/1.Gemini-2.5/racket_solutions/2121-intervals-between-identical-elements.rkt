#lang racket

(define (get-intervals-between-identical-elements arr)
  (define n (vector-length arr))
  (define result (make-vector n 0))
  (define val-to-indices (make-hash))

  (for ([i (in-range n)])
    (define val (vector-ref arr i))
    (hash-set! val-to-indices val (cons i (hash-ref val-to-indices val '()))))

  (hash-for-each
   val-to-indices
   (lambda (val indices-list)
     (define sorted-indices (sort indices-list <))
     (define k (length sorted-indices))
     (when (> k 1)
       (define total-sum-of-indices (foldl + 0 sorted-indices))
       (define prefix-sum-so-far 0)
       (define left-count 0)

       (for ([p_m sorted-indices])
         (define right-count (- k 1 left-count))
         (define suffix-sum-so-far (- total-sum-of-indices prefix-sum-so-far p_m))

         (define val-for-pm
           (+ (* left-count p_m)
              (- prefix-sum-so-far)
              suffix-sum-so-far
              (- (* right-count p_m))))

         (vector-set! result p_m val-for-pm)

         (set! prefix-sum-so-far (+ prefix-sum-so-far p_m))
         (set! left-count (+ left-count 1))))))

  result)