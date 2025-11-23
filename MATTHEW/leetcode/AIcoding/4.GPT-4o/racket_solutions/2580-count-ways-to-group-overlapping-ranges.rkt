(define (count-ways ranges)
  (define (merge-intervals intervals)
    (define sorted-intervals (sort intervals (λ (a b) (< (car a) (car b)))))
    (foldl
     (λ (current acc)
       (if (null? acc)
           (list current)
           (let ((last (car acc)))
             (if (<= (car last) (cdr current))
                 (cons (list (car last) (max (cdr last) (cdr current))) (cdr acc))
                 (cons current acc)))))
     '() sorted-intervals))

  (define merged (merge-intervals ranges))
  (define n (length merged))
  (define mod 1000000007)

  (if (zero? n)
      1
      (define dp (make-vector (+ n 1) 0))
      (vector-set! dp 0 1)
      (for ((i (in-range 1 (+ n 1))))
        (vector-set! dp i (modulo (+ (vector-ref dp (- i 1)) (vector-ref dp (- i 2))) mod)))
      (vector-ref dp n)))

(define (count-ways-to-group-overlapping-ranges ranges)
  (count-ways ranges))