(define (get-max-score nums1 nums2)
  (define MOD 1000000007)

  (let loop ((l1 nums1) (l2 nums2)
             (sum1 0) (sum2 0)
             (total-score 0))
    (cond
      ((or (empty? l1) (empty? l2))
       (values total-score sum1 sum2 l1 l2))

      (else
       (let ((val1 (car l1))
             (val2 (car l2)))
         (cond
           ((< val1 val2)
            (loop (cdr l1) l2
                  (modulo (+ sum1 val1) MOD) sum2
                  total-score))
           ((> val1 val2)
            (loop l1 (cdr l2)
                  sum1 (modulo (+ sum2 val2) MOD)
                  total-score))
           (else ; (= val1 val2)
            (let ((current-max-segment (max sum1 sum2)))
              (loop (cdr l1) (cdr l2)
                    0 0
                    (modulo (+ total-score current-max-segment val1) MOD)))))))))

    (let-values (((final-total-score final-sum1 final-sum2 remaining-l1 remaining-l2)
                  (loop nums1 nums2 0 0 0)))
      (let ((final-sum1-with-rest
             (foldl (lambda (x acc) (modulo (+ acc x) MOD)) final-sum1 remaining-l1))
            (final-sum2-with-rest
             (foldl (lambda (x acc) (modulo (+ acc x) MOD)) final-sum2 remaining-l2)))
        (modulo (+ final-total-score (max final-sum1-with-rest final-sum2-with-rest)) MOD))))