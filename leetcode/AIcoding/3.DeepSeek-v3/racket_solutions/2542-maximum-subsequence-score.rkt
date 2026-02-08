(define/contract (max-score nums1 nums2 k)
  (-> (listof exact-integer?) (listof exact-integer?) exact-integer? exact-integer?)
  (let* ([pairs (sort (map cons nums1 nums2) (lambda (a b) (> (cdr a) (cdr b))))]
         [n (length pairs)]
         [heap (make-heap (lambda (a b) (< a b)))])
    (heap-add! heap (car (car pairs)))
    (let loop ([sum (car (car pairs))]
               [i 1]
               [res (* sum (cdr (car pairs)))])
      (if (>= i n)
          res
          (let* ([current (list-ref pairs i)]
                 [new-sum (+ sum (car current))])
            (heap-add! heap (car current))
            (when (> (heap-count heap) k)
              (set! new-sum (- new-sum (heap-remove! heap))))
            (if (>= (heap-count heap) k)
                (loop new-sum (+ i 1) (max res (* new-sum (cdr current))))
                (loop new-sum (+ i 1) res))))))))