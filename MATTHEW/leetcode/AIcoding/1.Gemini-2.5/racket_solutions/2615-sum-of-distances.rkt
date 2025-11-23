(require racket/hash)
(require racket/vector)

(define (sum-of-distances nums-list)
  (define n (length nums-list))
  (define ans (make-vector n 0))

  (define val->indices (make-hash))
  (for ([i (in-range n)]
        [val nums-list])
    (hash-set! val->indices val (cons i (hash-ref val->indices val '()))))

  (for-each (lambda (pair)
              (define val (car pair))
              (define indices (cdr pair))
              (hash-set! val->indices val (reverse indices)))
            (hash-map->list val->indices))

  (hash-for-each
   val->indices
   (lambda (val indices)
     (define k (length indices))
     (when (> k 1)
       (define prefix-sums
         (let loop ([idx-list indices] [current-sum 0] [acc '()])
           (if (empty? idx-list)
               (reverse acc)
               (let ([new-sum (+ current-sum (car idx-list))])
                 (loop (cdr idx-list) new-sum (cons new-sum acc))))))

       (for ([i (in-range k)])
         (define current-idx (list-ref indices i))

         (define left-count i)
         (define left-sum-of-indices (if (> i 0) (list-ref prefix-sums (- i 1)) 0))

         (define right-count (- k 1 i))
         (define right-sum-of-indices (- (list-ref prefix-sums (- k 1)) (list-ref prefix-sums i)))

         (define calculated-dist
           (+ (- (* left-count current-idx) left-sum-of-indices)
              (- right-sum-of-indices (* right-count current-idx))))

         (vector-set! ans current-idx calculated-dist)))))

  (vector->list ans))