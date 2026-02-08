(define (reverse-pairs nums)
  (define (merge-sort nums left right)
    (if (<= left right)
        (values 0 nums)
        (let ((mid (quotient (+ left right) 2)))
          (let-values ([(count1 left-part) (merge-sort nums left mid)])
            (let-values ([(count2 right-part) (merge-sort left-part (+ mid 1) right)])
              (let-values ([(count3 merged-part) (merge left-part mid right-part right)])
                (values (+ count1 count2 count3) merged-part)))))))

  (define (merge left left-start left-end right right-end)
    (define (count-reverse-pairs left left-start left-end right right-start right-end)
      (cond [(> left-start left-end) 0]
            [(> right-start right-end) 0]
            [else
             (+ (length (filter (lambda (x) (> x (list-ref right right-start))) (take (drop left left-start) (+ 1 (- left-end left-start)))))
                (count-reverse-pairs left left-start left-end right (+ right-start 1) right-end))]))

    (define (merge-helper left left-start left-end right right-start right-end merged-list)
      (cond [(> left-start left-end) (append merged-list (drop right right-start))]
            [(> right-start right-end) (append merged-list (drop left left-start))]
            [else
             (if (<= (list-ref left left-start) (list-ref right right-start))
                 (merge-helper left (+ left-start 1) left-end right right-start right-end (append merged-list (list (list-ref left left-start))))
                 (merge-helper left left-start left-end right (+ right-start 1) right-end (append merged-list (list (list-ref right right-start)))))]))

    (values (count-reverse-pairs left left-start left-end right right-start right-end) (merge-helper left left-start left-end right right-start right-end '())))

  (let-values ([(count _) (merge-sort nums 0 (- (length nums) 1))])
    count))