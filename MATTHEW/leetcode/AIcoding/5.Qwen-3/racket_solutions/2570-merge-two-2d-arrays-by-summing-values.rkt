(define (merge-2d-arrays nums1 nums2)
  (define (merge-helper a b)
    (cond [(null? a) b]
          [(null? b) a]
          [else
           (let ([key1 (caar a)]
                 [val1 (cadar a)]
                 [key2 (caar b)]
                 [val2 (cadar b)])
             (cond [(= key1 key2)
                    (cons (list key1 (+ val1 val2)) (merge-helper (cdr a) (cdr b)))]
                   [(< key1 key2)
                    (cons (car a) (merge-helper (cdr a) b))]
                   [else
                    (cons (car b) (merge-helper a (cdr b)))]))]))
  (merge-helper nums1 nums2))